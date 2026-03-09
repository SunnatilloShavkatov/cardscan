package uz.shs.cardscan

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Parcelable
import com.getbouncer.cardscan.ui.CardScanActivity
import com.getbouncer.cardscan.ui.CardScanSheetResult
import com.getbouncer.cardscan.ui.ScannedCard
import com.getbouncer.scan.ui.CancellationReason
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class CardscanPlugin :
    FlutterPlugin,
    MethodCallHandler,
    ActivityAware,
    PluginRegistry.ActivityResultListener {
    private companion object {
        const val CHANNEL_NAME = "cardscan"
        const val REQUEST_CODE = 9472
        const val REQUEST_EXTRA = "request"
        const val RESULT_EXTRA = "result"
        const val PARAMS_CLASS = "com.getbouncer.cardscan.ui.CardScanSheetParams"
    }

    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private var activity: Activity? = null
    private var activityBinding: ActivityPluginBinding? = null
    private var pendingResult: Result? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        when (call.method) {
            "isSupported" -> {
                result.success(runCatching { isSupported() }.getOrDefault(false))
            }

            "scanCard" -> {
                startScan(call, result)
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        activityBinding = binding
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        clearActivityBinding()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        clearActivityBinding()
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ): Boolean {
        if (requestCode != REQUEST_CODE) {
            return false
        }

        val flutterResult = pendingResult
        pendingResult = null
        if (flutterResult == null) {
            return true
        }

        val sheetResult = data.parcelableExtra<CardScanSheetResult>(RESULT_EXTRA)
        when (sheetResult) {
            is CardScanSheetResult.Completed -> flutterResult.success(sheetResult.scannedCard.toMap())
            is CardScanSheetResult.Canceled -> {
                if (sheetResult.reason is CancellationReason.CameraPermissionDenied) {
                    flutterResult.error(
                        "camera_permission_denied",
                        "Camera permission denied",
                        null,
                    )
                } else {
                    flutterResult.success(null)
                }
            }
            is CardScanSheetResult.Failed -> {
                flutterResult.error(
                    "scan_failed",
                    sheetResult.error.message ?: "Card scan failed",
                    null,
                )
            }
            null -> {
                if (resultCode == Activity.RESULT_CANCELED) {
                    flutterResult.success(null)
                } else {
                    flutterResult.error("scan_failed", "No scan result returned", null)
                }
            }
        }
        return true
    }

    private fun isSupported(): Boolean {
        return CardScanSheetResult::class.java.classLoader != null &&
            com.getbouncer.cardscan.ui.CardScanSheet.isSupported(applicationContext)
    }

    private fun startScan(
        call: MethodCall,
        result: Result
    ) {
        val currentActivity = activity
        if (currentActivity == null) {
            result.error("no_activity", "Cardscan plugin requires a foreground activity", null)
            return
        }
        if (pendingResult != null) {
            result.error("scan_in_progress", "Another card scan is already in progress", null)
            return
        }

        val enableEnterManually = call.argument<Boolean>("enableEnterManually") ?: true
        val enableNameExtraction = call.argument<Boolean>("enableNameExtraction") ?: false
        val enableExpiryExtraction = call.argument<Boolean>("enableExpiryExtraction") ?: true

        pendingResult = result

        try {
            val params = buildSheetParams(
                enableEnterManually = enableEnterManually,
                enableNameExtraction = enableNameExtraction,
                enableExpiryExtraction = enableExpiryExtraction,
            )

            val intent = Intent(currentActivity, CardScanActivity::class.java)
                .putExtra(REQUEST_EXTRA, params)
            currentActivity.startActivityForResult(intent, REQUEST_CODE)
        } catch (error: Throwable) {
            pendingResult = null
            result.error("scan_setup_failed", error.message, null)
        }
    }

    private fun buildSheetParams(
        enableEnterManually: Boolean,
        enableNameExtraction: Boolean,
        enableExpiryExtraction: Boolean,
    ): Parcelable {
        val paramsClass = Class.forName(PARAMS_CLASS)
        return createSheetParamsInstance(
            paramsClass = paramsClass,
            enableEnterManually = enableEnterManually,
            enableNameExtraction = enableNameExtraction,
            enableExpiryExtraction = enableExpiryExtraction,
        )
    }

    internal fun createSheetParamsInstance(
        paramsClass: Class<*>,
        enableEnterManually: Boolean,
        enableNameExtraction: Boolean,
        enableExpiryExtraction: Boolean,
    ): Parcelable {
        val constructors = linkedMapOf(
            listOf(
                Boolean::class.javaPrimitiveType,
                Boolean::class.javaPrimitiveType,
                Boolean::class.javaPrimitiveType,
            ) to arrayOf(enableEnterManually, enableNameExtraction, enableExpiryExtraction),
            listOf(
                String::class.java,
                Boolean::class.javaPrimitiveType,
                Boolean::class.javaPrimitiveType,
                Boolean::class.javaPrimitiveType,
            ) to arrayOf("", enableEnterManually, enableNameExtraction, enableExpiryExtraction),
        )

        val constructor = paramsClass.declaredConstructors.firstOrNull { candidate ->
            constructors.keys.any { signature -> candidate.parameterTypes.contentEquals(signature.toTypedArray()) }
        } ?: throw NoSuchMethodException(
            "${paramsClass.name}.<init> ${paramsClass.declaredConstructors.joinToString(prefix = "[", postfix = "]") { it.parameterTypes.contentToString() }}"
        )

        constructor.isAccessible = true
        val args = constructors.entries.first { (signature, _) ->
            constructor.parameterTypes.contentEquals(signature.toTypedArray())
        }.value
        return constructor.newInstance(*args) as Parcelable
    }

    private fun clearActivityBinding() {
        activityBinding?.removeActivityResultListener(this)
        activityBinding = null
        activity = null
    }

    private fun ScannedCard.toMap(): Map<String, Any?> = mapOf(
        "cardNumber" to pan,
        "expiryMonth" to expiryMonth,
        "expiryYear" to expiryYear,
        "cardholderName" to cardholderName,
        "networkName" to networkName,
    )

    private inline fun <reified T> Intent?.parcelableExtra(key: String): T? {
        if (this == null) {
            return null
        }
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getParcelableExtra(key, T::class.java)
        } else {
            @Suppress("DEPRECATION")
            getParcelableExtra(key) as? T
        }
    }
}

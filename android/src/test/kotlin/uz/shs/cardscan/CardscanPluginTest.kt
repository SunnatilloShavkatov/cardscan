package uz.shs.cardscan

import android.os.Parcel
import android.os.Parcelable
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.mockito.Mockito
import kotlin.test.assertEquals
import kotlin.test.assertIs
import kotlin.test.Test

/*
 * This demonstrates a simple unit test of the Kotlin portion of this plugin's implementation.
 *
 * Once you have built the plugin's example app, you can run these tests from the command
 * line by running `./gradlew testDebugUnitTest` in the `example/android/` directory, or
 * you can run them directly from IDEs that support JUnit such as Android Studio.
 */

internal class CardscanPluginTest {
    @Suppress("unused")
    private class ThreeArgParams(
        val enableEnterManually: Boolean,
        val enableNameExtraction: Boolean,
        val enableExpiryExtraction: Boolean,
    ) : Parcelable {
        override fun describeContents(): Int = 0

        override fun writeToParcel(dest: Parcel, flags: Int) = Unit
    }

    @Suppress("unused")
    private class FourArgParams(
        val apiKey: String,
        val enableEnterManually: Boolean,
        val enableNameExtraction: Boolean,
        val enableExpiryExtraction: Boolean,
    ) : Parcelable {
        override fun describeContents(): Int = 0

        override fun writeToParcel(dest: Parcel, flags: Int) = Unit
    }

    @Test
    fun onMethodCall_unknownMethod_isNotImplemented() {
        val plugin = CardscanPlugin()

        val call = MethodCall("unknownMethod", null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).notImplemented()
    }

    @Test
    fun createSheetParamsInstance_supportsThreeArgumentSignature() {
        val plugin = CardscanPlugin()

        val result = plugin.createSheetParamsInstance(
            paramsClass = ThreeArgParams::class.java,
            enableEnterManually = true,
            enableNameExtraction = false,
            enableExpiryExtraction = true,
        )

        val typed = assertIs<ThreeArgParams>(result)
        assertEquals(true, typed.enableEnterManually)
        assertEquals(false, typed.enableNameExtraction)
        assertEquals(true, typed.enableExpiryExtraction)
    }

    @Test
    fun createSheetParamsInstance_fallsBackToLegacyFourArgumentSignature() {
        val plugin = CardscanPlugin()

        val result = plugin.createSheetParamsInstance(
            paramsClass = FourArgParams::class.java,
            enableEnterManually = true,
            enableNameExtraction = false,
            enableExpiryExtraction = true,
        )

        val typed = assertIs<FourArgParams>(result)
        assertEquals("", typed.apiKey)
        assertEquals(true, typed.enableEnterManually)
        assertEquals(false, typed.enableNameExtraction)
        assertEquals(true, typed.enableExpiryExtraction)
    }
}

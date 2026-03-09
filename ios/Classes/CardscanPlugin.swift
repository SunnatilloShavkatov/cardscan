import Flutter
import UIKit

public class CardscanPlugin: NSObject, FlutterPlugin, ScanDelegate {
  private var pendingResult: FlutterResult?
  private var enableNameExtraction = false
  private var enableExpiryExtraction = true

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cardscan", binaryMessenger: registrar.messenger())
    let instance = CardscanPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isSupported":
      result(ScanViewController.isCompatible())
    case "scanCard":
      scanCard(call: call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func scanCard(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard pendingResult == nil else {
      result(
        FlutterError(
          code: "scan_in_progress",
          message: "Another card scan is already in progress",
          details: nil
        )
      )
      return
    }

    guard let presenter = topViewController() else {
      result(
        FlutterError(
          code: "no_view_controller",
          message: "Unable to find a presenter for the card scanner",
          details: nil
        )
      )
      return
    }

    guard let scanViewController = ScanViewController.createViewController(withDelegate: self) else {
      result(
        FlutterError(
          code: "unsupported",
          message: "Card scanning is not supported on this device",
          details: nil
        )
      )
      return
    }

    let arguments = call.arguments as? [String: Any]
    enableNameExtraction = arguments?["enableNameExtraction"] as? Bool ?? false
    enableExpiryExtraction = arguments?["enableExpiryExtraction"] as? Bool ?? true
    let enableEnterManually = arguments?["enableEnterManually"] as? Bool ?? true

    scanViewController.allowSkip = enableEnterManually
    pendingResult = result
    presenter.present(scanViewController, animated: true)
  }

  public func userDidCancel(_ scanViewController: ScanViewController) {
    scanViewController.dismiss(animated: true)
    finish(with: nil)
  }

  public func userDidSkip(_ scanViewController: ScanViewController) {
    scanViewController.dismiss(animated: true)
    finish(with: nil)
  }

  public func userDidScanCard(_ scanViewController: ScanViewController, creditCard: CreditCard) {
    scanViewController.dismiss(animated: true)
    finish(
      with: [
        "cardNumber": creditCard.number,
        "expiryMonth": enableExpiryExtraction ? creditCard.expiryMonth : nil,
        "expiryYear": enableExpiryExtraction ? creditCard.expiryYear : nil,
        "cardholderName": enableNameExtraction ? creditCard.name : nil,
        "networkName": nil,
      ]
    )
  }

  private func finish(with value: Any?) {
    pendingResult?(value)
    pendingResult = nil
  }

  private func topViewController(
    from root: UIViewController? = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first(where: \.isKeyWindow)?
      .rootViewController
  ) -> UIViewController? {
    if let navigationController = root as? UINavigationController {
      return topViewController(from: navigationController.visibleViewController)
    }
    if let tabBarController = root as? UITabBarController {
      return topViewController(from: tabBarController.selectedViewController)
    }
    if let presentedViewController = root?.presentedViewController {
      return topViewController(from: presentedViewController)
    }
    return root
  }
}

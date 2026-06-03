//
//  CardScan.swift
//  CardScan
//
//  Created by Jaime Park on 1/29/20.
//

import Foundation

@available(*, deprecated, message: "Replaced by stripe card scan. See https://github.com/stripe/stripe-ios/tree/master/StripeCardScan")
public class CSBundle {
    // If you change the bundle name make sure to set these before
    // initializing the library
    public static var bundleIdentifier = "org.cocoapods.shs-cardscan"
    public static var cardScanBundle: Bundle?
    public static var namedBundle = "CardScan"
    public static var namedBundleExtension = "bundle"
    
    // Public for testing
    public static func bundle() -> Bundle? {
        if cardScanBundle != nil {
            return cardScanBundle
        }

        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        if let bundle = Bundle(identifier: bundleIdentifier) {
            return bundle
        }

        let classBundle = Bundle(for: CSBundle.self)
        if classBundle.bundleURL.pathExtension == "framework" || classBundle.url(forResource: "CardScan", withExtension: "storyboardc") != nil {
            return classBundle
        }

        guard let bundleUrl = Bundle(for: CSBundle.self).url(forResource: namedBundle, withExtension: namedBundleExtension) else {
            return nil
        }

        return Bundle(url: bundleUrl)
        #endif
    }
    
    static func compiledModel(forResource: String, withExtension: String) -> URL? {
        guard let bundle = bundle() else {
            return nil
        }
        
        guard let modelcUrl = bundle.url(forResource: forResource, withExtension: withExtension) else {
            print("Could not find bundle named \"\(forResource).\(withExtension)\"")
            return nil
        }
        
        return modelcUrl
    }
}

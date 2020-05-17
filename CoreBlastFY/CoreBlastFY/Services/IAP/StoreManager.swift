//
//  StoreManager.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//
/*
Abstract:
Retrieves product information from the App Store using SKRequestDelegate, SKProductsRequestDelegate, SKProductsResponse, and SKProductsRequest.
Notifies its observer with a list of products available for sale along with a list of invalid product identifiers. Logs an error message if the
product request failed.
*/

import StoreKit
import Foundation

// MARK: - StoreManagerDelegate

protocol StoreManagerDelegate: AnyObject {
    /// Provides the delegate with the error encountered during the product request.
    func storeManagerDidReceiveMessage(_ message: String)
}


class StoreManager: NSObject {
    // MARK: - Types

    static let shared = StoreManager()

    // MARK: - Properties

    /// Keeps track of all valid products. These products are available for sale in the App Store.
    fileprivate var availableProducts: [String?] = InAppIds.all

    weak var delegate: StoreManagerDelegate?

    // MARK: - Initializer

    private override init() {}

    // MARK: - Request Product Information
    
     func isPurchased(with id: String) -> Bool {
            let purchaseRecipt = UserDefaults.standard.bool(forKey: id)
            return purchaseRecipt
        }

    /// Starts the product request with the specified identifiers.
    func startProductRequest(with identifiers: String) {
        StoreObserver.shared.buyMealPlan(with: identifiers)
    }
}


// MARK: - SKRequestDelegate

/// Extends StoreManager to conform to SKRequestDelegate.
extension StoreManager: SKRequestDelegate {
    /// Called when the product request failed.
    func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.delegate?.storeManagerDidReceiveMessage(error.localizedDescription)
        }
    }
}

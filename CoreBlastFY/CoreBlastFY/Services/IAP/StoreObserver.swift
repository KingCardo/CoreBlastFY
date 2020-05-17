//
//  StoreObserver.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import StoreKit
import Foundation
// MARK: - StoreObserverDelegate

protocol StoreObserverDelegate: AnyObject {
    /// Tells the delegate that the restore operation was successful.
    func storeObserverRestoreDidSucceed()

    /// Provides the delegate with messages.
    func storeObserverDidReceiveMessage(_ message: String)
}
let PurchaseSuccess = NSNotification.Name("PurchaseSuccessNotification")
let PurchaseCancelled = NSNotification.Name("PurchaseCancelledNotification")

class StoreObserver: NSObject {
    // MARK: - Types

    static let shared = StoreObserver()
    var productId: String?

    // MARK: - Properties

    /**
    Indicates whether the user is allowed to make payments.
    - returns: true if the user is allowed to make payments and false, otherwise. Tell StoreManager to query the App Store when the user is
    allowed to make payments and there are product identifiers to be queried.
    */
    var isAuthorizedForPayments: Bool {
        return SKPaymentQueue.canMakePayments()
    }

    /// Keeps track of all purchases.
    var purchased = [SKPaymentTransaction]()

    /// Keeps track of all restored purchases.
    var restored = [SKPaymentTransaction]()

    /// Indicates whether there are restorable purchases.
    fileprivate var hasRestorablePurchases = false

    weak var delegate: StoreObserverDelegate?

    // MARK: - Initializer

    private override init() {}

    // MARK: - Submit Payment Request

    /// Create and add a payment request to the payment queue.
    func buyMealPlan(with id: String) {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = id
            SKPaymentQueue.default().add(paymentRequest)
    }

    // MARK: - Restore All Restorable Purchases

    /// Restores all previously completed purchases.
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // MARK: - Handle Payment Transactions

    /// Handles successful purchase transactions.
    fileprivate func handlePurchased(_ transaction: SKPaymentTransaction, id: String?) {
        guard let id = id else {
            return
        }
        NotificationCenter.default.post(Notification(name: PurchaseSuccess))
        UserDefaults.standard.set(true, forKey: id)
        
        print("\(Messages.deliverContent) \(transaction.payment.productIdentifier).")

        // Finish the successful transaction.
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    /// Handles failed purchase transactions.
    fileprivate func handleFailed(_ transaction: SKPaymentTransaction) {
        var message = "\(Messages.purchaseOf) \(transaction.payment.productIdentifier) \(Messages.failed)"

        if let error = transaction.error {
            message += "\n\(Messages.error) \(error.localizedDescription)"
            print("\(Messages.error) \(error.localizedDescription)")
        }
         NotificationCenter.default.post(Notification(name: PurchaseCancelled))

        // Do not send any notifications when the user cancels the purchase.
        if (transaction.error as? SKError)?.code != .paymentCancelled {
            DispatchQueue.main.async {
                self.delegate?.storeObserverDidReceiveMessage(message)
            }
        }
        // Finish the failed transaction.
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    /// Handles restored purchase transactions.
    fileprivate func handleRestored(_ transaction: SKPaymentTransaction) {
        DispatchQueue.main.async {
            self.delegate?.storeObserverRestoreDidSucceed()
        }
        // Finishes the restored transaction.
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

// MARK: - SKPaymentTransactionObserver

/// Extends StoreObserver to conform to SKPaymentTransactionObserver.
extension StoreObserver: SKPaymentTransactionObserver {
    /// Called when there are transactions in the payment queue.
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing: break
            // Do not block your UI. Allow the user to continue using your app.
            case .deferred: print(Messages.deferred)
            // The purchase was successful.
            case .purchased: handlePurchased(transaction, id: productId)
            // The transaction failed.
            case .failed: handleFailed(transaction)
            // There are restored products.
            case .restored: handleRestored(transaction)
            @unknown default: fatalError("\(Messages.unknownDefault)")
            }
        }
    }

    /// Logs all transactions that have been removed from the payment queue.
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print ("\(transaction.payment.productIdentifier) \(Messages.removed)")
        }
    }

    /// Called when an error occur while restoring purchases. Notify the user about the error.
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let error = error as? SKError, error.code != .paymentCancelled {
            DispatchQueue.main.async {
                self.delegate?.storeObserverDidReceiveMessage(error.localizedDescription)
            }
        }
    }

    /// Called when all restorable transactions have been processed by the payment queue.
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print(Messages.restorable)

        if !hasRestorablePurchases {
            DispatchQueue.main.async {
                self.delegate?.storeObserverDidReceiveMessage(Messages.noRestorablePurchases)
            }
        }
    }
}


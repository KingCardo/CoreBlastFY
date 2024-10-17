//
//  SubscriptionView.swift
//  Sixpack Blueprint
//
//  Created by Riccardo Washington on 10/11/24.
//  Copyright © 2024 Riccardo Washington. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

struct SubscriptionOption: Identifiable, Equatable {
    let id: String
    let title: String
    let price: String
    let billingPeriod: String
    let savings: String?
    let cta: String
    var freeTrial = false
}

class PurchaseViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    var callBack: ((Bool) -> Void)?
    @State var isPurchasing = false
    
    init() {
        // Add observers for notifications
        NotificationCenter.default.publisher(for: PurchaseSuccess)
            .sink { [weak self] _ in
                self?.purchaseSuccess()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: PurchaseCancelled)
            .sink { [weak self] _ in
                self?.purchaseCancelled()
            }
            .store(in: &cancellables)
    }
    
    func restore() {
        StoreObserver.shared.restore()
    }
    
    // Handle purchase success
    func purchaseSuccess() {
        withAnimation {
            isPurchasing = false
        }
        callBack?(true)
    }
    
    // Handle purchase cancellation
    func purchaseCancelled() {
        withAnimation {
            isPurchasing = false
        }
        callBack?(false)
    }
}


struct SubscriptionView: View {
    @Binding var currentStep: Int
    var callBack: ((Bool) -> Void)?
    // Subscription options
    let options: [SubscriptionOption] = [
        SubscriptionOption(id: InAppIds.premiumWeekly,title: "Weekly", price: "$5.99", billingPeriod: "per week", savings: nil, cta: "SUBSCRIBE"),
        SubscriptionOption(id: InAppIds.premiumMonthly,title: "Monthly", price: "$12.99", billingPeriod: "per month", savings: nil, cta: "TRY FOR FREE", freeTrial: true),
        SubscriptionOption(id: InAppIds.premiumAnnual,title: "Annual", price: "$59.99", billingPeriod: "per year", savings: "Save 40%", cta: "SUBSCRIBE")
    ]
    
    @State private var selectedOption: SubscriptionOption?
    @StateObject private var viewModel = PurchaseViewModel()
   
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.0, green: 0.75, blue: 0.85),  // Vibrant Cyan
                    Color(red: 0.0, green: 0.42, blue: 1.0),   // Strong Blue
                    Color(red: 0.55, green: 0.0, blue: 1.0)    // Deep Purple
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                // Title
                Text("Choose Your Plan")
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 32, relativeTo: .title))
                    .bold()
                    .padding(.top, 40)
                
                // Subtitle
                Text("Get the abs you want with personalized workouts and nutrition plans.")
                    .font(Font.custom("AppleSDGothicNeo-Regular", size: 24, relativeTo: .body))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Subscription Options List
                VStack(spacing: 15) {
                    ForEach(options) { option in
                        SubscriptionOptionView(option: option, selectedOption: $selectedOption)
                    }
                }
                .padding()
                
                // Subscribe Button
                Button(action: {
                    if selectedOption != nil {
                        makePurchase(iap: selectedOption!)
                    }
                }) {
                    Text(selectedOption?.cta ?? "Continue")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedOption != nil ? Color(UIColor.goatBlue) : Color(UIColor.goatBlack))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                
                // Terms and Conditions
                
                Text("By subscribing, you agree to our Terms of Service and Privacy Policy.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                HStack {
                    Button(action: viewModel.restore) {
                        Text("Restore", comment: "restore iap")
                            .font(.caption2)
                            .foregroundColor(Color.blue)
                    }
                    
                    Spacer()
                        .frame(width: 16)
                    
                    Link(destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) {
                        Text("Terms & Conditions")
                            .font(.caption2)
                            .foregroundColor(Color.blue)
                    }
                }
            }
            if viewModel.isPurchasing {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
        }
        .onAppear {
            viewModel.callBack = { success in
                callBack?(success)
            }
        }
    }
    
    private func makePurchase(iap: SubscriptionOption) {
        withAnimation {
            viewModel.isPurchasing = true
        }
        StoreManager.shared.startProductRequest(with: iap.id)
    }
}

// View for each subscription option
struct SubscriptionOptionView: View {
    let option: SubscriptionOption
   // var onSelect: (SubscriptionOption) -> Void
    @Binding var selectedOption: SubscriptionOption?

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    // Option Title and Billing Info
                    VStack(alignment: .leading, spacing: 4) {
                        Text(option.title)
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 20, relativeTo: .title))
                        Text(option.billingPeriod)
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 18, relativeTo: .title))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    // Price Info
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(option.price)
                            .font(.headline)
                        if let savings = option.savings {
                            Text(savings)
                                .font(.footnote)
                                .foregroundColor(.green)
                        }
                    }
                }
                .padding()
                .background(selectedOption == option ? Color.blue.opacity(0.7) : Color(UIColor.goatBlack))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                selectedOption = option
            }
            if option.freeTrial {
                HStack {
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 1.0, green: 0.843, blue: 0.0))
                            .frame(width: 110, height: 30)
                        
                        Text("Free Week Trial")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.black)
                    }
                    //  .padding(.trailing)
                    .offset(x: -20, y: -32)
                }
            }
        }
    }
}

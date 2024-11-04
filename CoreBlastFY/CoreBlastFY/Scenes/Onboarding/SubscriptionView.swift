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
    let ctaTitle: String
    var freeTrial = false
}

class PurchaseViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    var callBack: ((Bool) -> Void)?
    @Published var isPurchasing = false
    
    init() {
        // Add observers for notifications
        NotificationCenter.default.publisher(for: PurchaseSuccess)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.purchaseSuccess()
                }
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: PurchaseCancelled)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.purchaseCancelled()
                }
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
        SubscriptionOption(id: InAppIds.premiumWeekly,title: "Weekly", price: "$2.99", billingPeriod: "per week", savings: nil, cta: "SUBSCRIBE",  ctaTitle: "$2.99 weekly. Cancel Anytime."),
        SubscriptionOption(id: InAppIds.premiumMonthly,title: "Monthly", price: "$4.99", billingPeriod: "per month", savings: nil, cta: "TRY FOR FREE", ctaTitle: "7 day free trial then $4.99 monthly. Cancel Anytime.", freeTrial: true),
        SubscriptionOption(id: InAppIds.premiumAnnual,title: "Annual", price: "$19.99", billingPeriod: "per year", savings: "Save 65%", cta: "SUBSCRIBE", ctaTitle: "$19.99 Billed annually. Cancel Anytime.")
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
            
            contentBody
       
            if viewModel.isPurchasing {
                Color.black.opacity(0.4) // Background overlay
                    .edgesIgnoringSafeArea(.all) // Fill the entire screen
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(Color.black) // Background for the spinner
                    .cornerRadius(10)
            }
        
        }
        .onAppear {
            viewModel.callBack = { success in
                if success {
                    callBack?(success)
                }
            }
        }
    }
    
    var contentBody: some View {
        VStack(spacing: 20) {
            // Title
            Text("Choose Your Plan")
                .font(Font.custom("AppleSDGothicNeo-Bold", size: 32, relativeTo: .title))
                .bold()
                .padding(.top, 40)
            
            // Subtitle
            Text("Get the abs you want with simple customized workouts.")
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
                    print("selected purchase RWRW")
                }
            }) {
                Text(selectedOption?.cta ?? "Select an option")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedOption != nil ? Color(UIColor.goatBlue) : Color(UIColor.goatBlack))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .disabled(viewModel.isPurchasing)
            
            // Terms and Conditions
            
            Text(selectedOption?.ctaTitle ?? "Cancel anytime.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            HStack {
                Link(destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) {
                    Text("Terms & Conditions")
                        .font(.caption2)
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
    
    private func makePurchase(iap: SubscriptionOption) {
        viewModel.isPurchasing = true
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
                            .foregroundColor((selectedOption == option ? .white : .gray))
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

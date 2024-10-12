//
//  SubscriptionView.swift
//  Sixpack Blueprint
//
//  Created by Riccardo Washington on 10/11/24.
//  Copyright © 2024 Riccardo Washington. All rights reserved.
//

import UIKit
import SwiftUI


import SwiftUI

struct SubscriptionOption: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let price: String
    let billingPeriod: String
    let savings: String?
    let cta: String
    var freeTrial = false
}

struct SubscriptionView: View {
    @Binding var currentStep: Int
    var callBack: (() -> Void)?
    // Subscription options
    let options: [SubscriptionOption] = [
        SubscriptionOption(title: "Weekly", price: "$5.99", billingPeriod: "per week", savings: nil, cta: "SUBSCRIBE"),
        SubscriptionOption(title: "Monthly", price: "$12.99", billingPeriod: "per month", savings: nil, cta: "TRY FOR FREE", freeTrial: true),
        SubscriptionOption(title: "Annual", price: "$79.99", billingPeriod: "per year", savings: "Save 40%", cta: "SUBSCRIBE")
    ]
    
    @State private var selectedOption: SubscriptionOption?

    var body: some View {
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
                    callBack?()
                }
                // Handle subscription action here
            }) {
                Text(selectedOption?.cta ?? "Continue")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
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
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea()
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

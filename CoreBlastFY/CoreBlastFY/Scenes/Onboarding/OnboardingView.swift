//
//  OnboardingView.swift
//  Sixpack Blueprint
//
//  Created by Riccardo Washington on 10/11/24.
//  Copyright © 2024 Riccardo Washington. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0

    var body: some View {
        NavigationView {
            VStack {
                if currentStep == 0 {
                    IntroView(currentStep: $currentStep)
                } else if currentStep == 1 {
                    NotificationsView(currentStep: $currentStep)
                } else if currentStep == 2 {
                    ReviewRequestView(currentStep: $currentStep)
                } else if currentStep == 3 {
                    BenefitsView(currentStep: $currentStep)
                } else if currentStep == 4 {
                    SubscriptionView(currentStep: $currentStep) {
                        currentStep += 1
                        OnboardingViewController.completion?()
                        UserDefaults.standard.set(true, forKey: onboardingKey)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct IntroView: View {
    @Binding var currentStep: Int

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
//            Image("inapppromopic")
//                .resizable()
//                .scaledToFit()
//                .ignoresSafeArea()
           
            VStack {
                Spacer()
                Text("Welcome to the SixPack Blueprint!")
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 32, relativeTo: .title))
                    .padding()
                
                Text("Achieve a stronger core and chiseled six pack with our customized workout plan.")
                    .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                    .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        currentStep += 1
                    }
                }) {
                    Text("Next")
                        .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                        .frame(width: UIScreen.main.bounds.size.width * 0.8)
                        .padding()
                        .background(Color(UIColor.goatBlue))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

struct NotificationsView: View {
    @Binding var currentStep: Int

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
//            Image("inapppromopic")
//                .resizable()
//                .scaledToFit()
//                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Enable Notifications")
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 32, relativeTo: .title))
                    .padding()
                
                Text("Stay on track with reminders and updates about your workout plan.")
                    .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                    .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        currentStep += 1
                    }
                }) {
                    Text("Skip")
                        .frame(width: UIScreen.main.bounds.size.width * 0.8)
                        .padding()
                }
                
                Button(action: {
                    withAnimation {
                        currentStep += 1
                    }
                }) {
                    Text("Allow Notifications")
                        .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                        .frame(width: UIScreen.main.bounds.size.width * 0.8)
                        .padding()
                        .background(Color(UIColor.goatBlue))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
               
            }
            .padding()
        }
    }
}

struct ReviewRequestView: View {
    @Binding var currentStep: Int

    var body: some View {
        ZStack {
//            Image("inapppromopic")
//                .resizable()
//                .scaledToFit()
//                .ignoresSafeArea()
            
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
            VStack {
                Spacer()
                Text("Help Us Grow!")
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 32, relativeTo: .title))
                    .padding()
                
                Text("Your app store review helps helps us reach more people like you trying to get chiseled!")
                    .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                    .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        currentStep += 1
                    }
                }) {
                    Text("Rate us")
                        .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                        .frame(width: UIScreen.main.bounds.size.width * 0.8)
                        .padding()
                        .background(Color(UIColor.goatBlue))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

struct BenefitsView: View {
    @Binding var currentStep: Int

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
//            Image("inapppromopic")
//                .resizable()
//                .scaledToFit()
//                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Why Follow the Blueprint?")
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 32, relativeTo: .title))
                    .padding()
                
                Text("Following our program helps you build a sustainable fitness routine, ensuring long-term success and progress and great results.")
                    .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                    .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        currentStep += 1
                    }
                }) {
                    Text("Get Started!")
                        .font(Font.custom("AppleSDGothicNeo-Regular", size: 20, relativeTo: .body))
                        .frame(width: UIScreen.main.bounds.size.width * 0.8)
                        .padding()
                        .background(Color(UIColor.goatBlue))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

struct ContentView: View {
    var body: some View {
        OnboardingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

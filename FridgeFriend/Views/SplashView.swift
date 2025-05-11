//
//  SplashView.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import SwiftUI

struct SplashView: View {
    @State private var animatePulse = false
    @State private var animateBounce = false
    @State private var showTitle = false
    @State private var navigateToDashboard = false

    var body: some View {
        ZStack {
            Color("Almond")
                .ignoresSafeArea()
                .overlay(
                    Circle()
                        .fill(Color("PaleDogwood").opacity(0.3))
                        .scaleEffect(animatePulse ? 1.1 : 0.9)
                        .frame(width: 300, height: 300)
                        .blur(radius: 30)
                        .animation(
                            .easeInOut(duration: 1.6).repeatForever(autoreverses: true),
                            value: animatePulse
                        )
                )

            VStack(spacing: 16) {
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 140)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                    .shadow(radius: 12)
                    .scaleEffect(animateBounce ? 1.0 : 0.6)
                    .offset(y: animateBounce ? 0 : -50)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 15), value: animateBounce)

                if showTitle {
                    Text("FridgeFriend")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Charcoal"))
                        .transition(.opacity)
                        .animation(.easeIn(duration: 1.0), value: showTitle)
                }
            }
        }
        .onAppear {
            animatePulse = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                animateBounce = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                showTitle = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                withAnimation {
                    navigateToDashboard = true
                }
            }
        }
        .fullScreenCover(isPresented: $navigateToDashboard) {
            DashboardView()
        }
    }
}

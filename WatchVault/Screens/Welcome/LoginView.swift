//
//  LoginView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

struct LoginView: View {
    
    var namespace: Namespace.ID
    @Binding var currentView: WelcomeScreenView
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                TestFieldView(text: $email, icon: ImageLiteral.envelope.image, placeholder: AppManager.shared.currentLocalization.email)
                SecureTextFieldView(text: $password, icon: ImageLiteral.lock.image, placeholder: AppManager.shared.currentLocalization.password)
            }
            .padding(.bottom, 25)
            ButtonView(title: AppManager.shared.currentLocalization.login) {
                AppManager.shared.changeScreen(to: .main)
            }.matchedGeometryEffect(id: NameSpaceKey.login.rawValue, in: namespace)
            ButtonView(buttonType: .text, title: AppManager.shared.currentLocalization.signUpRoute, shadowRadius: 1) {
                withAnimation {
                    currentView = .signUp
                }
            }
            Spacer()
        }.padding()
    }
}

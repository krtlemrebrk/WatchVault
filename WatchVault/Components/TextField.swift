//
//  TextField.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 12.04.2023.
//

import SwiftUI

struct TestFieldView: View {
    
    @EnvironmentObject var appManager: AppManager
    @Binding var text: String
    let icon: Image
    let placeholder: String
    let cornerRadius: CGFloat
    let background: Colors
    let fixedBackground: Color
    let foreground: Colors
    let fixedForeground: Color
    let isColorsFixed: Bool
    
    init(text: Binding<String>, icon: Image, placeholder: String, cornerRadius: CGFloat = 20, background: Colors = .foreground, foreground: Colors = .background) {
        self._text = text
        self.icon = icon
        self.placeholder = placeholder
        self.cornerRadius = cornerRadius
        self.background = background
        self.fixedBackground = .clear
        self.foreground = foreground
        self.fixedForeground = .clear
        self.isColorsFixed = false
    }
    
    init(text: Binding<String>, icon: Image, placeholder: String, cornerRadius: CGFloat = 20, fixedBackground: Color, fixedForeground: Color) {
        self._text = text
        self.icon = icon
        self.placeholder = placeholder
        self.cornerRadius = cornerRadius
        self.background = .foreground
        self.fixedBackground = fixedBackground
        self.foreground = .background
        self.fixedForeground = fixedForeground
        self.isColorsFixed = true
    }

    var body: some View {
        HStack {
            icon.resizable().scaledToFit().frame(maxWidth: 20, maxHeight: 20).foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
            
            TextField(text: $text) {
                Text(placeholder)
                    .foregroundColor((isColorsFixed ? fixedForeground : foreground.value).opacity(0.5))
            }
            .foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
        .padding()
        .background(isColorsFixed ? fixedBackground : background.value)
        .cornerRadius(cornerRadius)
    }
}

struct SecureTextFieldView: View {
    
    @EnvironmentObject var appManager: AppManager
    @Binding var text: String
    let icon: Image
    let placeholder: String
    let cornerRadius: CGFloat
    let background: Colors
    let fixedBackground: Color
    let foreground: Colors
    let fixedForeground: Color
    let isColorsFixed: Bool
    @FocusState var focus: Int?
    @State var showPassword: Bool = false
    
    init(text: Binding<String>, icon: Image, placeholder: String, cornerRadius: CGFloat = 20, background: Colors = .foreground, foreground: Colors = .background) {
        self._text = text
        self.icon = icon
        self.placeholder = placeholder
        self.cornerRadius = cornerRadius
        self.background = background
        self.fixedBackground = .clear
        self.foreground = foreground
        self.fixedForeground = .clear
        self.isColorsFixed = false
    }
    
    init(text: Binding<String>, icon: Image, placeholder: String, cornerRadius: CGFloat = 20, fixedBackground: Color, fixedForeground: Color) {
        self._text = text
        self.icon = icon
        self.placeholder = placeholder
        self.cornerRadius = cornerRadius
        self.background = .foreground
        self.fixedBackground = fixedBackground
        self.foreground = .background
        self.fixedForeground = fixedForeground
        self.isColorsFixed = true
    }

    var body: some View {
        HStack {
            icon.resizable().scaledToFit().frame(maxWidth: 20, maxHeight: 20).foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
            
            ZStack {
                TextField(text: $text) {
                    Text(placeholder)
                        .foregroundColor((isColorsFixed ? fixedForeground : foreground.value).opacity(0.5))
                }
                .foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
                .textContentType(.password)
                .focused($focus, equals: 1)
                .opacity(showPassword ? 1 : 0)
                
                SecureField(text: $text) {
                    Text(placeholder)
                        .foregroundColor((isColorsFixed ? fixedForeground : foreground.value).opacity(0.5))
                }
                .foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
                .textContentType(.password)
                .focused($focus, equals: 2)
                .opacity(showPassword ? 0 : 1)
            }

            Button(action: {
                showPassword.toggle()
                focus = showPassword ? 1 : 2
            }, label: {
                (showPassword ? ImageLiteral.eyeSlash.image : ImageLiteral.eye.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20, maxHeight: 20)
                    .foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
        .padding()
        .background(isColorsFixed ? fixedBackground : background.value)
        .cornerRadius(cornerRadius)
    }
}

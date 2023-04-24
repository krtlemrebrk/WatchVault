//
//  WelcomeScreen.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI
import Combine

enum NameSpaceKey: String {
    case login
    case signUp
}

enum WelcomeScreenView {
    case welcome
    case login
    case signUp
}

struct BackgroundGridImage: Identifiable {
    let id: String
    let image: Image
}

struct WelcomeScreen: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject var tmdbManager = TMDBManager.shared
    @Namespace private var namespace
    @State var images: [BackgroundGridImage] = [BackgroundGridImage]()
    @State var selectedLanguage: Language = AppManager.shared.currentLanguage
    @State var currentView: WelcomeScreenView = .welcome
    private var columnGrid: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 4)

    var body: some View {
        ContainerView {
            backgroundView
        } content: {
            VStack {
                ZStack {
                    if currentView != .welcome {
                        HStack {
                            Button {
                                withAnimation {
                                    currentView = .welcome
                                }
                            } label: {
                                ImageLiteral.back.image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Colors.foreground.value)
                            }
                            Spacer()
                        }
                    }

                    ImageLiteral.appLogo.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    
                    if currentView == .welcome {
                        HStack {
                            Spacer()
                            Menu {
                                Picker(selection: $selectedLanguage, label: EmptyView()) {
                                    ForEach(Language.allCases, id: \.self) { language in
                                        TextView(text: language.name)
                                    }
                                }.pickerStyle(.inline).accentColor(AppManager.shared.currentColorPalette.foreground)
                            } label: {
                                TextView(text: selectedLanguage.rawValue.localizedUppercase, font: .title3)
                            }.tint(AppManager.shared.currentColorPalette.foreground)
                        }
                    }
                }.padding()

                switch currentView {
                case .welcome: welcomeView
                case .login: LoginView(namespace: namespace, currentView: $currentView).transition(.move(edge: .leading))
                case .signUp: SignUpView(namespace: namespace, currentView: $currentView).transition(.move(edge: .trailing))
                }
            }
        }.onChange(of: selectedLanguage) { newValue in
            AppManager.shared.changeLanguage(to: selectedLanguage)
            Task {
                let result = await TMDBManager.shared.getTrending().map({ BackgroundGridImage(id: UUID().uuidString, image: $0) })
                await MainActor.run(body: {
                    self.images = result
                })
            }
        }.onViewDidLoad {
            Task {
                let result = await TMDBManager.shared.getTrending().map({ BackgroundGridImage(id: UUID().uuidString, image: $0) })
                await MainActor.run(body: {
                    self.images = result
                })
                AppManager.shared.splashScreen(show: false)
            }
        }
    }
    
    var backgroundView: some View {
        LazyVGrid(columns: columnGrid, alignment: .center, spacing: 0) {
            ForEach(images) { image in
                image.image.resizable().scaledToFit()
            }
        }
        .mask(LinearGradient(gradient: Gradient(colors: [.clear, .black, .clear]), startPoint: .top, endPoint: .bottom))
        .mask(Color.black.opacity(0.3))
    }
    
    var welcomeView: some View {
        VStack {
            Spacer()
            TextView(text: AppManager.shared.currentLocalization.welcomeDescription, font: .title, shadowRadius: 5)
            Spacer()
            TextView(text: AppManager.shared.currentLocalization.welcomeStart, alignment: .leading)
            ButtonView(title: AppManager.shared.currentLocalization.login, action: {
                withAnimation {
                    currentView = .login
                }
            }).matchedGeometryEffect(id: NameSpaceKey.login.rawValue, in: namespace)
            ButtonView(buttonType: .outline, title: AppManager.shared.currentLocalization.signUp, action: {
                withAnimation {
                    currentView = .signUp
                }
            }).matchedGeometryEffect(id: NameSpaceKey.signUp.rawValue, in: namespace)
        }.padding()
    }
}

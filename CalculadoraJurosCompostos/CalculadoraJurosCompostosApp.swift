//
//  CalculadoraJurosCompostosApp.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 07/11/22.
//

import SwiftUI

@main
struct CalculadoraJurosCompostosApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
        }
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//
//  MainView.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 12/12/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            JurosCompostosView()
                .tabItem{
                    Label("Juros Compostos", systemImage: "globe")
                }
            JurosSimplesView()
                .tabItem{
                    Label("Juros Simples", systemImage: "globe")
                }
            HelpView()
                .tabItem{
                    Label("Consulta", systemImage: "globe")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

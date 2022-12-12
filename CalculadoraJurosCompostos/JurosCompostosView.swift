//
//  ContentView.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 07/11/22.
//

import SwiftUI

struct JurosCompostosView: View {
    
    @State private var initialValue = ""
    @State private var mensalValue = ""
    @State var color = Color("placeholderColor")
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                VStack(alignment: .leading){
                    Spacer()
                    Group{
                        Text("Valor Inicial")
                            .foregroundColor(Color("textColor"))
                        ZStack(alignment: .leading){
                            Text("R$ \(moneyFormatter(initialValue))")
                                .foregroundColor(checkColor(initialValue))
                            TextField("", text: $initialValue)
                                .padding(.leading, 25.0)
                                .foregroundColor(.clear)
                                .tint(.clear)
                                .keyboardType(.numberPad)
                        }
                    }
                    Group{
                        Text("Valor Mensal")
                            .foregroundColor(Color("textColor"))
                        ZStack(alignment: .leading){
                            Text("R$ \(moneyFormatter(mensalValue))")
                                .foregroundColor(checkColor(mensalValue))
                            TextField("", text: $mensalValue)
                                .padding(.leading, 25.0)
                                .foregroundColor(.clear)
                                .tint(.clear)
                                .keyboardType(.numberPad)
                        }
                    }
                    Spacer()
                }
                .frame(width: 330, height: 332, alignment: .bottom)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func checkColor(_ thingToCheck: String) -> Color{
        if thingToCheck == "" {
            return Color("placeholderColor")
        }else{
            return Color("textColor")
        }
    }
    
    func moneyFormatter(_ number: String) -> String{
        var numberFormatted = number.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        var divided: Double = 0
        if let floatNumber = Double(numberFormatted){
            divided = floatNumber/100
        }
        numberFormatted = String(format: "%.2f", divided)
        numberFormatted = numberFormatted.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        return numberFormatted
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JurosCompostosView()
    }
}


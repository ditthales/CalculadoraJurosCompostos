//
//  ContentView.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 07/11/22.
//

import SwiftUI

struct JurosCompostosView: View {
    
    @State var initialValue = ""
    @State var mensalValue = ""
    @State var interet = ""
    @State var color = Color("placeholderColor")
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                VStack(alignment: .leading, spacing: 20){
                    Spacer()
                    Group{
                        Text("Valor Inicial")
                            .foregroundColor(Color("textColor"))
                            .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.medium)
                        ZStack(alignment: .leading){
                            Text("R$ \(moneyFormatter(initialValue))")
                                .foregroundColor(checkColor(initialValue))
                                .font(Font.custom("Helvetica Neue", size: 20)).bold()
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
                            .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.medium)
                        ZStack(alignment: .leading){
                            Text("R$ \(moneyFormatter(mensalValue))")
                                .foregroundColor(checkColor(mensalValue))
                                .font(Font.custom("Helvetica Neue", size: 20)).bold()
                            TextField("", text: $mensalValue)
                                .padding(.leading, 25.0)
                                .foregroundColor(.clear)
                                .tint(.clear)
                                .keyboardType(.numberPad)
                        }
                    }
                    Group{
                        Text("Taxa de juros (%)")
                            .foregroundColor(Color("textColor"))
                            .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.medium)
                        HStack{
                            ZStack(alignment: .leading){
                                Text("\(moneyFormatter(interet)) %")
                                    .foregroundColor(checkColor(interet))
                                    .font(Font.custom("Helvetica Neue", size: 20)).bold()
                                TextField("", text: $interet)
                                    .padding(.leading, 25.0)
                                    .foregroundColor(.clear)
                                    .tint(.clear)
                                    .keyboardType(.numberPad)
                            }
                            
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


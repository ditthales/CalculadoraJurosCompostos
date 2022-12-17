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
    @State var time = ""
    @State var labelJurosDropdown = "mensal"
    @State var labelTempoDropdown = "meses"
    @State var color = Color("placeholderColor")
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                HStack(alignment: .bottom){
                    VStack(alignment: .leading, spacing: (geo.size.height/50)){
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
                                        .foregroundColor(.clear)
                                        .tint(.clear)
                                        .keyboardType(.numberPad)
                                }
                                DropDownJuros(label: $labelJurosDropdown)
                            }
                        }
                        Group{
                            Text("Período em:")
                                .foregroundColor(Color("textColor"))
                                .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.medium)
                            HStack{
                                ZStack(alignment: .leading){
                                    Text(timeFormatter(time))
                                        .foregroundColor(checkColor(time))
                                        .font(Font.custom("Helvetica Neue", size: 20)).bold()
                                    TextField("", text: $time)
                                        .foregroundColor(.clear)
                                        .tint(.clear)
                                        .keyboardType(.numberPad)
                                }
                                DropDownTempo(label: $labelTempoDropdown)
                            }
                        }
                        if geo.size.height > 668{
                            Spacer()
                        }
                        Group{
                            HStack{
                                Button{
                                    //MARK: Configurar aqui botao limpar
                                }label: {
                                    ZStack{
                                        Image("SecondaryButtonBG")
                                        HStack{
                                            Text("Limpar")
                                                .foregroundColor(Color("textColor"))
                                                .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.light)
                                            Image(systemName: "eraser")
                                                .foregroundColor(Color("textColor"))
                                                .padding(.top, 2.0)
                                                
                                                
                                        }
                                        .padding(.bottom, 10.0)
                                    }
                                }
                                Button{
                                    //MARK: Configurar aqui botão calcular
                                }label: {
                                    ZStack{
                                        Image("PrimaryButtonBG")
                                        HStack{
                                            Text("Calcular")
                                                .foregroundColor(Color("TextButtonColor"))
                                                .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.light)
                                            Image(systemName: "arrow.up")
                                                .foregroundColor(Color("TextButtonColor"))
                                                .padding(.top, 2.0)
                                                
                                                
                                        }
                                        .padding(.bottom, 10.0)
                                    }
                                }
                            }
                        }
                        Spacer()
                        if geo.size.height < 668{
                            Spacer()
                        }
                    }
                    .frame(width: 330, height: 332, alignment: .bottom)
                }
                .padding(.top, geo.size.height/4)
                
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func checkColor(_ thingToCheck: String) -> Color{
        if thingToCheck == "" || thingToCheck == "0" {
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
    
    func timeFormatter(_ number: String) -> String{
        if number == ""{
            return "0"
        }else{
            return number
        }
    }
}

struct DropDownJuros: View{
    
    @Binding var label: String
    
    var body: some View{
        Button{
            //TODO: TROCAR A FUNCAO
            if label == "mensal"{
                label = "anual"
            }else if label == "anual"{
                label = "mensal"
            }else if label == "anos"{
                label = "meses"
            }else if label == "meses"{
                label = "anos"
            }
        }label: {
            ZStack(alignment: .center){
                Image("DropdownBG")
                HStack{
                    Text(label)
                        .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.light)
                    Image(systemName: "arrow.left.arrow.right")
                        .foregroundColor(Color("TextButtonColor"))
                        .padding(.top, 2.0)
                        
                        
                }
                .padding(.bottom, 10.0)
            }
        }
        .foregroundColor(Color("TextButtonColor"))
    }
}

struct DropDownTempo: View{
    
    @Binding var label: String
    
    var body: some View{
        Button{
            //TODO: TROCAR A FUNCAO
            if label == "mensal"{
                label = "anual"
            }else if label == "anual"{
                label = "mensal"
            }else if label == "anos"{
                label = "meses"
            }else if label == "meses"{
                label = "anos"
            }
        }label: {
            ZStack(alignment: .center){
                Image("DropdownBG")
                HStack{
                    Text(label)
                        .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.light)
                    Image(systemName: "arrow.left.arrow.right")
                        .foregroundColor(Color("TextButtonColor"))
                        .padding(.top, 2.0)
                        
                        
                }
                .padding(.bottom, 10.0)
            }
        }
        .foregroundColor(Color("TextButtonColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JurosCompostosView()
    }
}


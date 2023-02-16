//
//  JurosSimplesView.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 12/12/22.
//


import SwiftUI

struct JurosSimplesView: View {
    
    @State private var willMoveToNextScreen = false
    
    @State var initialValue: Double = 0
    @State var interet: Double = 0
    @State var time = ""
    @State var labelJurosDropdown = "mensal"
    @State var labelTempoDropdown = "meses"
    @State var color = Color("placeholderColor")
    
    @State var arrayResults: [Double] = []
    @State var arrayTotalInvestido: [Double] = []
    @State var arrayTotalJuros: [Double] = []
    
    
    var body: some View {
        ZStack{
            Color("textColor")
            ZStack {
                VStack(spacing: 0){
                    if UIScreen.main.bounds.height > 668{
                        Image("Image")
                            .padding(.top, 60.0)
                    }else{
                        Image("Image")
                            .padding(.top, 20.0)
                    }
                    RoundedRectangle(cornerRadius: 30, style: .circular)
                        .foregroundColor(Color("BackgroundColor"))
                }
                VStack{
                    VStack(spacing: 25){
                        VStack(alignment: .leading){
                            Text("Valor Inicial")
                                .foregroundColor(Color("textColor"))
                                .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.medium)
                            CurrencyTextField(value: $initialValue)
                                .foregroundColor(checkColorValues(initialValue))
                            .font(Font.custom("Helvetica Neue", size: 20)).bold()
                            .keyboardType(.numberPad)
                        }
                        VStack(alignment: .leading){
                            Text("Taxa de juros (%)")
                                .foregroundColor(Color("textColor"))
                                .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.medium)
                            HStack {
                                InteretTextField(value: $interet)
                                    .foregroundColor(checkColorValues(interet))
                                .font(Font.custom("Helvetica Neue", size: 20)).bold()
                                .keyboardType(.numberPad)
                                
                                DropDownJuros(label: $labelJurosDropdown)
                            }
                        }
                        VStack(alignment: .leading){
                            Text("Período em: ")
                                .foregroundColor(Color("textColor"))
                                .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.medium)
                            HStack {
                                TextField("0", text: $time)
                                .font(Font.custom("Helvetica Neue", size: 20)).bold()
                                .foregroundColor(checkColorValues(Double(time) ?? 0))
                                .keyboardType(.numberPad)
                                
                                Button(action: {
                                    self.time = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(Font.custom("Helvetica Neue", size: 20)).bold()
                                        .foregroundColor(checkColorValues(Double(time) ?? 0))
                                }
                                
                                DropDownTempo(label: $labelTempoDropdown)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    if UIScreen.main.bounds.height > 668{
                        Rectangle()
                            .frame(height: 30)
                            .foregroundColor(.clear)
                    }
                    
                    HStack{
                        Button{
                            print(initialValue)
                            print(interet)
                            print(time)
                            limparForm()
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
                        
                        Spacer()
                        
                        Button{
                            //MARK: Configurar aqui botão calcular
                            calcular()
                            if isFormOkay(){
                                willMoveToNextScreen.toggle()
                            }
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
                    .padding(.horizontal)
                }
                .padding(.top, 100.0)
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            self.hideKeyboard()
        }
        .sheet(isPresented: $willMoveToNextScreen, onDismiss: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                limparDados()
            }
        }){
            ResultsView(arrayResults: $arrayResults, arrayTotalInvestido: $arrayTotalInvestido, arrayTotalJuros: $arrayTotalJuros, isPresented: $willMoveToNextScreen)
        }
    }
    
    func limparForm(){
        initialValue = 0
        interet = 0
        time = ""
    }
    
    func limparDados(){
        arrayResults = []
        arrayTotalJuros = []
        arrayTotalInvestido = []
    }
    
    func checkColorValues(_ thingToCheck: Double) -> Color{
        if thingToCheck == 0{
            return Color("placeholderColor")
        }else{
            return Color("textColor")
        }
    }
    
    func calcular(){
        
        if isFormOkay(){
            
            var cTime: Int
            if labelTempoDropdown == "meses"{
                cTime = (Int(time) ?? 0)
            }else{
                cTime = (Int(time) ?? 0) * 12
            }
            
            var cInteret: Double
            if labelJurosDropdown == "mensal"{
                cInteret = interet/100
            }else{
                let juros = interet/100
                cInteret = juros/12
                print("o interet anual foi: \(cInteret)")
            }
            
            let improvedInteret = cInteret + 1
            print("o improved interet ficou de \(improvedInteret)")
            
            var sum = initialValue * cInteret
            var result = initialValue
            
            for _ in 0...(cTime-1) {
                result = result + sum
                arrayResults.append(result)
            }
            
            for _ in 0...(cTime-1) {
                let totalInvestido = initialValue
                arrayTotalInvestido.append(totalInvestido)
            }
            
            for i in 0...(cTime-1) {
                let totalEmJuros = arrayResults[i] - arrayTotalInvestido[i]
                arrayTotalJuros.append(totalEmJuros)
            }
        }
        
    }
    
    func isFormOkay() -> Bool{
        if time == ""{
            return false
        }
        if initialValue == 0{
            return false
        }
        return true
    }
    
}


struct JurosSimplesView_Previews: PreviewProvider {
    static var previews: some View {
        JurosSimplesView()
    }
}

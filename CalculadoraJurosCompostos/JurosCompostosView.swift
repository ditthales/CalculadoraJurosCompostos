//
//  ContentView.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 07/11/22.
//

import SwiftUI

struct JurosCompostosView: View {
    
    @State private var willMoveToNextScreen = false
    
    @State var initialValue = ""
    @State var mensalValue = ""
    @State var interet = ""
    @State var time = ""
    @State var labelJurosDropdown = "mensal"
    @State var labelTempoDropdown = "meses"
    @State var color = Color("placeholderColor")
    
    @State var arrayResults: [Double] = []
    @State var arrayTotalInvestido: [Double] = []
    @State var arrayTotalJuros: [Double] = []
    
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
                                    .foregroundColor(checkColorValues(initialValue))
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
                                    .foregroundColor(checkColorValues(mensalValue))
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
                                        .foregroundColor(checkColorTaxes(interet))
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
                                        .foregroundColor(checkColorTaxes(time))
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
                            HStack(alignment: .center){
                                Button{
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
                                Button{
                                    //MARK: Configurar aqui botão calcular
                                    if !(initialValue.isEmpty || mensalValue.isEmpty || interet.isEmpty || time.isEmpty) {
                                        calcular()
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
                        }
                        Spacer()
                        if geo.size.height < 668{
                            Spacer()
                        }
                    }
                    .padding(20)
                    
                }
                .padding(.top, geo.size.height/5)
                
            }
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.hideKeyboard()
            }
            .sheet(isPresented: $willMoveToNextScreen, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    limparDados()
                }
            }){
//                ResultsView(arrayResults: $arrayResults, arrayTotalInvestido: $arrayTotalInvestido, arrayTotalJuros: $arrayTotalJuros)
                ResultsView(arrayResults: $arrayResults, arrayTotalInvestido: $arrayTotalInvestido, arrayTotalJuros: $arrayTotalJuros, isPresented: $willMoveToNextScreen)
            }
        }
    }
    
    func calcular(){
        
        if isFormOkay(){
            let cInitValue: Double = (Double(initialValue) ?? 0)/100
            let cMensalValue: Double = (Double(mensalValue) ?? 0)/100
            
            var cTime: Int
            if labelTempoDropdown == "meses"{
                cTime = (Int(time) ?? 0)
            }else{
                cTime = (Int(time) ?? 0) * 12
            }
            
            var cInteret: Double
            if labelJurosDropdown == "mensal"{
                cInteret = (Double(interet) ?? 0)/10000
            }else{
                let juros = (Double(interet) ?? 0)/10000
                cInteret = ((pow((1+juros), (1/12)))-1)
                print("o interet anual foi: \(cInteret)")
            }
            
            let improvedInteret = cInteret + 1
            print("o improved interet ficou de \(improvedInteret)")
            
            var result = cInitValue
            
            for _ in 0...(cTime-1) {
                result = result * improvedInteret
                result = result + cMensalValue
                arrayResults.append(result)
            }
            
            for i in 0...(cTime-1) {
                let totalInvestido = cInitValue + cMensalValue * Double((i+1))
                arrayTotalInvestido.append(totalInvestido)
            }
            
            for i in 0...(cTime-1) {
                let totalEmJuros = arrayResults[i] - arrayTotalInvestido[i]
                arrayTotalJuros.append(totalEmJuros)
            }
        }
        
    }
    
    func isFormOkay() -> Bool{
        if initialValue != "" || mensalValue != "" {
            if interet != "" && interet != "0" && time != "" && time != "0"{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func limparForm(){
        initialValue = ""
        mensalValue = ""
        interet = ""
        time = ""
    }
    
    func limparDados(){
       
        arrayResults = []
        arrayTotalJuros = []
        arrayTotalInvestido = []
    }
    
    func checkColorTaxes(_ thingToCheck: String) -> Color{
        if thingToCheck == "" || thingToCheck == "0" {
            return Color("placeholderColor")
        }else{
            return Color("textColor")
        }
    }
    
    func checkColorValues(_ thingToCheck: String) -> Color{
        if thingToCheck == ""{
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

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.columns)
    }
}


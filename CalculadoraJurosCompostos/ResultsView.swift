//
//  ResultsView.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 12/12/22.
//

import SwiftUI
import SwiftUICharts
import UIKit


struct ResultsView: View {
    
    @Binding var arrayResults: [Double]
    @Binding var arrayTotalInvestido: [Double]
    @Binding var arrayTotalJuros: [Double]
    
    //    @State var arrayResults: [Double] = [0]
    //    @State var arrayTotalInvestido: [Double] = [0]
    //    @State var arrayTotalJuros: [Double] = [0]
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack{
            Image("HomeIndicator")
            ScrollView{
                VStack{
                    Spacer()
                    Group{
                        //                CardResult(texto: "Valor total final", valor: "R$ \(String(format: "%.2f", arrayResults.last!))", color: "textColor")
                        //                CardResult(texto: "Juros totais", valor: "R$ \(String(format: "%.2f", arrayTotalJuros.last!))", color: "textoJurosTotais")
                        //                CardResult(texto: "Valor total investido", valor: "R$ \(String(format: "%.2f", arrayTotalInvestido.last!))", color: "textoTotalInvestido")
                        Text("Resultados")
                            .foregroundColor(Color("textColor"))
                            .font(Font.custom("Helvetica Neue", size: 32)).fontWeight(.regular)
                        CardResult(texto: "Valor total final", valor: "R$ \(String(format: "%.2f", arrayResults.last!))", color: "textColor")
                        CardResult(texto: "Juros totais", valor: "R$ \(String(format: "%.2f", arrayTotalJuros.last!))", color: "textoJurosTotais")
                        CardResult(texto: "Valor total investido", valor: "R$ \(String(format: "%.2f", arrayTotalInvestido.last!))", color: "textoTotalInvestido")
                        
                    }.padding(10)
                    Rectangle().frame(height: 2).padding(.vertical, 30)
                    Group{
                        Text("Gráficos")
                            .foregroundColor(Color("textColor"))
                            .font(Font.custom("Helvetica Neue", size: 32)).fontWeight(.regular)
                        //Rectangle().frame(height: 200)
                        GraphView(arrayResults: $arrayResults, arrayTotalInvestido: $arrayTotalInvestido, arrayTotalJuros: $arrayTotalJuros)
                    }
                    Text("*Os resultados dessa calculadora são simulações. Podendo assim, sofrer divergências causadas por mudanças nas regulamentações e taxas. Este aplicativo tem caráter informativo, sem valor legal. Portanto, não dispensa a consulta de um profissional da área.").padding(30)
                        .frame(width: 390)
                    Group{
                        VStack{
                            ShareLink(item: getShareImage(), preview: SharePreview("Resultado", image: getShareImage())) {
                                ZStack{
                                    Image("secondaryButtonResults")
                                    HStack{
                                        Text("Compartilhar resultado")
                                            .foregroundColor(Color("textColor"))
                                            .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.light)
                                        Image(systemName: "square.and.arrow.up")
                                            .foregroundColor(Color("textColor"))
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                            Button{
                                isPresented.toggle()
                            }label: {
                                ZStack{
                                    Image("primaryButtonResults")
                                    HStack{
                                        Text("Calcular novamente")
                                            .foregroundColor(Color("TextButtonColor"))
                                            .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.light)
                                        Image(systemName: "arrow.clockwise")
                                            .foregroundColor(Color("TextButtonColor"))
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                        }
                    }
                    Spacer()
                }.background(Color("BackgroundColor"))
            }.background(Color("BackgroundColor"))
        }.background(Color("BackgroundColor"))
    }
    
    var shareView: some View {
        VStack{
            Spacer()
            
            Group{
                Text("Resultados")
                    .foregroundColor(Color("textColor"))
                    .font(Font.custom("Helvetica Neue", size: 32)).fontWeight(.regular)
                CardResult(texto: "Valor total final", valor: "R$ \(String(format: "%.2f", arrayResults.last!))", color: "textColor")
                CardResult(texto: "Juros totais", valor: "R$ \(String(format: "%.2f", arrayTotalJuros.last!))", color: "textoJurosTotais")
                CardResult(texto: "Valor total investido", valor: "R$ \(String(format: "%.2f", arrayTotalInvestido.last!))", color: "textoTotalInvestido")
                
            }.padding(10)
            
            Rectangle().frame(height: 2).padding(.vertical, 30)
            
            Text("*Os resultados dessa calculadora são simulações. Podendo assim, sofrer divergências causadas por mudanças nas regulamentações e taxas. Este aplicativo tem caráter informativo, sem valor legal. Portanto, não dispensa a consulta de um profissional da área.").padding(30)
                .frame(width: 390)
        }.background(.white)
    }
    
    @MainActor func getShareImage() -> Image{
        guard let image = ImageRenderer(content: shareView).uiImage else{return Image("Image")}
        
        return Image(uiImage: image)
    }
}

struct GraphView: View{
    
    @State private var pickerIndex = 0
    @Binding var arrayResults: [Double]
    @Binding var arrayTotalInvestido: [Double]
    @Binding var arrayTotalJuros: [Double]
    @State var meses = 1
    @State var barChartData: [(String, Double)] = [("",0)]
    @State var pieChartData: [Double] = [50,50]
    @State var rateValue: Int = 14
    
    var body: some View{
        VStack{
            ZStack{
                Picker("Favorite Color", selection: $pickerIndex, content: {
                    Text("Barras").tag(0)
                    Text("Pizza").tag(1)
                    Text("Linha").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(20)
            }.onAppear{
                var i: Int = 1
                barChartData = []
                pieChartData = [arrayTotalInvestido.last!, arrayTotalJuros.last!]
                rateValue = Int((arrayTotalJuros.last! / arrayResults.last!)*100)
                print(rateValue)
                for element in arrayResults{
                    barChartData.append(("Mês \(i)", element))
                    i = i + 1
                }
            }
            Group{
                if pickerIndex == 0{
                    BarChartView(data: ChartData(values: barChartData),
                                 title: "Evolução",
                                 form: CGSize(width: 330, height: 316)
                    )
                }else if pickerIndex == 1{
                    PieChartView(data: pieChartData,
                                 title: "Total de Juros",
                                 form: CGSize(width: 330, height: 316))
                }else if pickerIndex == 2{
                    LineChartView(data: arrayResults,
                                  title: "Evolução",
                                  form: CGSize(width: 330, height: 200),
                                  rateValue: rateValue)
                }
            }
        }
    }
}

struct CardResult: View{
    
    var texto: String = "Valor"
    var valor: String = "R$ 0,00"
    var color: String = "textColor"
    
    var body: some View{
        ZStack{
            Image("BoxResultados")
            VStack{
                Text(texto) .foregroundColor(Color(color))
                    .font(Font.custom("Helvetica Neue", size: 24)).fontWeight(.regular)
                Text(valor)
                    .padding(15)
                    .foregroundColor(Color(color))
                    .font(Font.custom("Helvetica Neue", size: 32)).fontWeight(.bold)
            }
        }
    }
    
}


//struct ResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultsView()
//    }
//}

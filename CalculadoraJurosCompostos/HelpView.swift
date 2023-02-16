//
//  HelpView.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 12/12/22.
//

import SwiftUI

struct HelpView: View {
    
    @State var inpc: String
    @State var ipca: String
    @State var selic: String
    
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
                VStack(spacing: 30){
                    ZStack {
                        Image("FrameSelic")
                        VStack(spacing: 41){
                            Text("Selic")
                                .foregroundColor(Color("textColor"))
                                .font(Font.custom("Helvetica Neue", size: 32)).fontWeight(.regular)
                            if let response = selic{
                                Text(response)
                                    .foregroundColor(Color("textColor"))
                                    .font(Font.custom("Helvetica Neue", size: 32)).fontWeight(.bold)
                            } else {
                                Text("Carregando...")
                                    .foregroundColor(Color("textColor"))
                                    .font(Font.custom("Helvetica Neue", size: 32)).fontWeight(.bold)
                            }
                        }
                        .padding(.bottom, 64.0)
                    }
                    HStack(spacing: 30){
                        ZStack {
                            Image("FrameIPCA")
                            VStack(spacing: 17){
                                Text("IPCA (últimos 12 meses)")
                                    .foregroundColor(Color("textColor"))
                                    .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.regular)
                                if let response = ipca{
                                    Text(response)
                                        .foregroundColor(Color("textColor"))
                                        .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.bold)
                                } else {
                                    Text("Carregando...")
                                        .foregroundColor(Color("textColor"))
                                        .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.bold)
                                }
                            }
                            .padding(.bottom, 34.0)
                        }
                        ZStack {
                            Image("FrameINPC")
                            VStack(spacing: 17){
                                Text("INPC")
                                    .foregroundColor(Color("textColor"))
                                    .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.regular)
                                if let response = inpc{
                                    Text(response)
                                        .foregroundColor(Color("textColor"))
                                        .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.bold)
                                } else {
                                    Text("Carregando...")
                                        .foregroundColor(Color("textColor"))
                                        .font(Font.custom("Helvetica Neue", size: 16)).fontWeight(.bold)
                                }
                                
                            }
                            .padding(.bottom, 34.0)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear{
            Task{
                self.inpc = await INPC.getINPC()
                self.ipca = await IPCA.getIPCA()
                self.selic = await Selic.getSelic()
            }
        }
    }
}


//struct HelpView_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpView()
//    }
//}

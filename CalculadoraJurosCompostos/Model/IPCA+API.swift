//
//  IPCA+API.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 16/02/23.
//

import Foundation

extension IPCA{
    static let url = URL(string: "https://apisidra.ibge.gov.br/values/t/1737/p/last/v/2265/n1/1")
    
    static func getIPCA() async -> String{
        
        let session = URLSession.shared
        
        do{
            guard let url = url else {
                return "erro1"
            }
            
            let (data, response) = try await session.data(from: url)
            let xmlDecoder = JSONDecoder()
            let apiResponse = try xmlDecoder.decode([IPCA].self, from: data)
            let valor = apiResponse[1].valor
            return "\(valor)% a.a."
        } catch {
            print("Erro ao decodificar o JSON: \(error.localizedDescription)")
        }
        
        return "erro2"
    }
}

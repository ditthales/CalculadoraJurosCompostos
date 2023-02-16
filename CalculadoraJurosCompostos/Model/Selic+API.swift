//
//  Selic+API.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 16/02/23.
//

import Foundation

extension Selic{
    static let url = URL(string: "https://api.bcb.gov.br/dados/serie/bcdata.sgs.1178/dados/ultimos/1?formato=json")
    
    static func getSelic() async -> String{
        
        let session = URLSession.shared
        
        do{
            guard let url = url else {
                return "erro1"
            }
            
            let (data, response) = try await session.data(from: url)
            let xmlDecoder = JSONDecoder()
            let apiResponse = try xmlDecoder.decode([Selic].self, from: data)
            guard let valor = apiResponse.last?.valor else {return "erro3"}
            return "\(valor)% a.a."
        } catch {
            print("Erro ao decodificar o JSON: \(error.localizedDescription)")
        }
        
        return "erro2"
    }
}

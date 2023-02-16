//
//  Selic.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 16/02/23.
//

import Foundation

struct Selic: Codable {
    let valor: String
    
    enum CodingKeys: String, CodingKey {
        case valor
    }
}

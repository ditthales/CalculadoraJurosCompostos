//
//  INPC.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 16/02/23.
//

import Foundation


struct INPC: Codable {
    var valor: String

    enum CodingKeys: String, CodingKey {
        case valor = "V"
    }
}

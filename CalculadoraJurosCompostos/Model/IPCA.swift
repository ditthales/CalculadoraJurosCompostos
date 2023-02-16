//
//  IPCA.swift
//  CalculadoraJurosCompostos
//
//  Created by ditthales on 16/02/23.
//

import Foundation

struct IPCA: Codable {
    var valor: String

    enum CodingKeys: String, CodingKey {
        case valor = "V"
    }
}

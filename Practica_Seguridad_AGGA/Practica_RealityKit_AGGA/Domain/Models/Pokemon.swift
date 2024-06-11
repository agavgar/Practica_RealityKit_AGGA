//
//  Pokemon.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int?
    let name: String?
    let sprites: PokemonSprites?
    let stats: [PokemonStats]?
}

struct PokemonSprites: Codable {
    let front_default: String?
    let front_shiny: String?
}

struct PokemonStats: Codable {
    let effort: Int?
    let base_stat:Int?
}


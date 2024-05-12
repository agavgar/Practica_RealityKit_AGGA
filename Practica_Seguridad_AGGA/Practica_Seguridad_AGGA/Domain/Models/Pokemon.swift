//
//  Pokemon.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

struct Pokemon: Codable {
    let id: Int?
    let name: String?
    let sprite: PokemonSprites?
    let stats: PokemonStats?
}

struct PokemonSprites: Codable {
    let front_default: String?
    let front_shiny: String?
}

struct PokemonStats: Codable {
    let effort: Int?
    let base_stat:Int?
}

struct Item: Codable {
    let id: Int?
    let name: String?
    let cost: Int?
    let sprite: ItemSprite?
}

struct ItemSprite: Codable {
    let item_Default: String?
}

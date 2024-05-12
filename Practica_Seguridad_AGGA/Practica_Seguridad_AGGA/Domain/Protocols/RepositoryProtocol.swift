//
//  RepositoryProtocol.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

protocol RepositoryProtocol {
    
    // MARK: Properties
    var apiProvider: ApiProviderProtocol { get }
    
    // MARK: Functions
    func getPokemon() async throws -> [Pokemon]
    func getItem() async throws -> [Item]
}

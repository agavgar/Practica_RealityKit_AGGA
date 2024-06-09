//
//  RepositoryApiProvider.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

final class RepositoryApiProvider: RepositoryProtocol {
    
    //MARK: - Properties
    var apiProvider: ApiProviderProtocol
    
    //MARK: - Init
    init(apiProvider: ApiProviderProtocol) {
        self.apiProvider = apiProvider
    }
    
    func getPokemon() async throws -> [Pokemon] {
        return try await apiProvider.getPokemons()
    }
    
}

//
//  RemoteProtocols.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

protocol RemoteURLRequestProtocol {
    
    //MARK: - Properties
    var endpoints: Endpoints { get }
    
    //MARK: - Functions
    func URLRequestPokemon(number: String) -> URLRequest?
    func URLRequestItem(number: String) -> URLRequest?
}

protocol ApiProviderProtocol {
    
    // MARK: Properties
    var remoteURLRequest: RemoteURLRequestProtocol { get }
    
    // MARK: Functions
    func getPokemons() async throws  -> [Pokemon]
    func getItems() async throws  -> [Item]
}

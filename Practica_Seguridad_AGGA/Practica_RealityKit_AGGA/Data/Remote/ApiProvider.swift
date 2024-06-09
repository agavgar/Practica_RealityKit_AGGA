//
//  URLRequestHelper.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

final class RemoteURLRequest: RemoteURLRequestProtocol {
    
    var endpoints: Endpoints = Endpoints()
    func URLRequestPokemon(number: String) -> URLRequest? {
        guard let url = URL (string: "\(endpoints.url)\(endpoints.pokemon)\(number)") else {
            print("Error ApiProvider -> RemoteURLRequest -> URLRequestPokemon")
            return nil
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        return request
    }
}

final class ApiProvider: ApiProviderProtocol {
    
    var remoteURLRequest: any RemoteURLRequestProtocol = RemoteURLRequest()
    
    func getPokemons() async throws -> [Pokemon] {
        var pokedex: [Pokemon] = []
        
        for i in 1...remoteURLRequest.endpoints.pokemonCount {
                    
            // Get the URLRequest
            guard let remoteURLRequest = remoteURLRequest.URLRequestPokemon(number: "\(i)") else {
                print("Error ApiProvider -> getPokemon -> URLPokemon")
                return []
            }
            
            // Get the data
            let (data, response) = try await URLSession.shared.data(for: remoteURLRequest)
            // Transform the response into a HTTPURLResponse to access the status code
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error ApiProvider -> getPokemon -> HTTPURLResponse")
                return []
            }
            let statusCode = httpResponse.statusCode
            
            // Check the status code
            switch statusCode {
                
            // If the status code is 200, saves Pokemon to the List
            case 200:
                // Convert the data into a String and check if it is empty
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                print(pokemon)
                pokedex.append(pokemon)
                print(pokedex)
            // If the status code is 401, return (nil, authenticationError)
            case 401:
                print("Error while authenticating the user")
                
            // If the status code is 500, return (nil, serverError)
            case 500:
                print("Error while authenticating the user")
                
            // If the status code is unknown, return (nil, unknownError)
            default:
                print("Unknown error")
            }
            
        }
        /*
        // Guardar la lista de pokemons encriptandola.
        let jsonData = try JSONEncoder().encode(pokedex)
        SecurityData.securityShare.save(pokemon: jsonData)
        */
        return pokedex
    }
}

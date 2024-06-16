//
//  RootViewModel.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

enum Status {
    case loading, loaded
}

@MainActor
final class PokemonViewModel: ObservableObject {

    //MARK: - Properties
    var repository: RepositoryProtocol
    @Published var pokemons = [Pokemon]()
    @Published var status = Status.loading
    @Published var count = 0
    @Published var win = false
    
    //MARK: - Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
        if self.pokemons.isEmpty {
            loadAllData()
        }
    }
    
    //MARK: - Functions
    func loadAllData() {
        self.status = .loading
        Task(){
            await getPokemon()
        }
    }
    
    func getPokemon() async {
        do {
            let data = try await repository.getPokemon()
            if data.count != 0 {
                self.pokemons = data
                self.status = .loaded
            }else{
                print("HomeViewModel -> getPokemons -> No data in load")
            }
        }catch{
            print("HomeViewModel -> getPokemons -> Error in catch")
        }
    }
    
    func pokemonCaptured(){
        self.count += 1
        if count == 3 {
            win = true
        }else{
            win = false
        }
    }
    
    func reset() {
        self.count = 0
        self.win = false
    }
}

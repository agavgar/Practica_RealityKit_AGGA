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
    @Published var selectedPokemon = ""
    
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
}

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

final class HomeViewModel: ObservableObject {

    //MARK: - Properties
    var repository: RepositoryProtocol
    @Published var pokemons = [Pokemon]()
    @Published var items = [Item]()
    @Published var status = Status.loading
    
    //MARK: - Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
        if self.pokemons.isEmpty && self.items.isEmpty {
            loadAllData()
        }
    }
    
    //MARK: - Functions
    func loadAllData() {
        status = .loading
        Task(){
            async let allPokemon = self.getPokemon()
            async let allItems = self.getItems()
            await allPokemon
            await allItems
            DispatchQueue.main.async {
                self.status = .loaded
            }
        }
    }
    
    func getPokemon() async {
        do {
            let data = try await repository.getPokemon()
            if data.count != 0 {
                DispatchQueue.main.async {
                    self.pokemons = data
                }
            }else{
                print("HomeViewModel -> getPokemons -> No data in load")
            }
        }catch{
            print("HomeViewModel -> getPokemons -> Error in catch")
        }
    }
    
    func getItems() async {
        do {
            let data = try await repository.getItem()
            if data.count != 0 {
                DispatchQueue.main.async {
                    self.items = data
                }
            }else{
                print("HomeViewModel -> getItems -> No data in load")
            }
        }catch{
            print("HomeViewModel -> getItems -> Error in catch")
        }

    }
}

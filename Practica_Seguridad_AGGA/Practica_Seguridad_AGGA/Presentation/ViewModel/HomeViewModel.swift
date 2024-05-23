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
    @Published var pokemon = [Pokemon]()
    @Published var items = [Item]()
    @Published var status = Status.loading
    
    //MARK: - Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
        if self.pokemon.isEmpty && self.items.isEmpty {
            loadAllData()
        }
    }
    
    //MARK: - Functions
    func loadAllData() {
        status = .loading
        DispatchQueue.main.async {
            Task(){
                await self.getPokemon()
                await self.getItems()
                DispatchQueue.main.async {
                    self.status = .loaded
                }
            }
        }
    }
    
    func getPokemon() async {
        do {
            let data = try await repository.getPokemon()
            if data.count != 0 {
                DispatchQueue.main.async {
                    self.pokemon = data
                }
            }else{
                print("RootViewModel -> getPokemons -> No data in load")
            }
        }catch{
            print("RootViewModel -> getPokemons -> Error in catch")
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
                print("RootViewModel -> getItems -> No data in load")
            }
        }catch{
            print("RootViewModel -> getItems -> Error in catch")
        }

    }
}

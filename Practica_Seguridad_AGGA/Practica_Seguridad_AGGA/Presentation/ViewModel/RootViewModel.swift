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

final class RootViewModel: ObservableObject {

    //MARK: - Properties
    var repository: RepositoryProtocol
    @Published var pokemon = [Pokemon]()
    @Published var status = Status.loading
    
    //MARK: - Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
        loadPokemonsAPI()
    }
    
    //MARK: - Functions
    func loadPokemosData() {
        SecurityData.securityShare.authenticateUser {
            if $0 {
                self.status = .loading
                let data = SecurityData.securityShare.loadPokemon()
                if data != nil {
                    DispatchQueue.main.async {
                        self.status = .loaded
                        self.pokemon = data!
                    }
                }else{
                    print("RootViewModel -> LoadData -> No data in load")
                }
            }else{
                self.loadPokemonsAPI()
            }
        }
    }
    
    func loadPokemonsAPI() {
        Task{
            await getPokemon()
            DispatchQueue.main.async {
                self.status = .loaded
            }
        }
    }
    
    func getPokemon() async {
        status = .loading
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
}

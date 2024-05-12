//
//  RootViewModel.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/5/24.
//

import Foundation

enum Status {
    case none, loading, loaded
}

final class RootViewModel: ObservableObject {

    //MARK: - Properties
    let repository: RepositoryProtocol
    @Published var pokemon = [Pokemon]()
    @Published var status = Status.none
    
    //MARK: - Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    //MARK: - Functions
    func loadPokemons() {
        status = .loading
        let data = SecurityData.securityShare.loadPokemon()
        if data != nil {
            DispatchQueue.main.async {
                self.status = .loaded
                self.pokemon = data!
            }
        }else{
            print("RootViewModel -> LoadData -> No data in load")
        }
    }
    
    func getPokemon() async {
        status = .loading
        Task{
            let data = try await repository.getPokemon()
            if data.count != 0 {
                DispatchQueue.main.async {
                    self.status = .loaded
                    self.pokemon = data
                }
            }else{
                print("RootViewModel -> getPokemons -> No data in load")
            }
        }
    }
}

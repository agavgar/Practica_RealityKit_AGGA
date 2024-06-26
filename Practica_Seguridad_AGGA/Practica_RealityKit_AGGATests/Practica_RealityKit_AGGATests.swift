//
//  Practica_RealityKit_AGGATests.swift
//  Practica_RealityKit_AGGATests
//
//  Created by Alejandro Gavira on 26/6/24.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Practica_RealityKit_AGGA

extension PokemonViewModel: Observable {}

final class Practica_SwiftUI_AGGATests: XCTestCase {
    
    func testExample() {
        XCTAssertEqual(1, 1)
    }
    
    func testHTTPMethod() {
        let test = HTTPMethods()
        XCTAssertNotNil(test)
    }
    
    func testEndpoints() {
        let test = Endpoints()
        XCTAssertNotNil(test)
    }
    
    func testEndpointsInside() {
        let test = Endpoints().pokemon
        let test2 = Endpoints().pokemonCount
        let test3 = Endpoints().url
        XCTAssertNotNil(test)
        XCTAssertNotNil(test2)
        XCTAssertNotNil(test3)
    }
    
    func testApiProvider() async throws {
        let test = ApiProvider()
        XCTAssertNotNil(test)
    }
    
    func testApiProviderGetPokemon() async throws {
        let test = ApiProvider()
        let pokemon = try await test.getPokemons()
        XCTAssertNotNil(pokemon)
    }
    
    func testRepositoryApiProvider() async throws {
        let apiProvider = ApiProvider()
        let test = RepositoryApiProvider(apiProvider: apiProvider)
        XCTAssertNotNil(test)
    }
    
    func testSoundManager() async throws {
        let test = SoundManager()
        XCTAssertNotNil(test)
    }
    
    func testSoundManagerPlaySound() async throws {
        let test = SoundManager()
        let sound = test.playSound("blastoise")
        XCTAssertNotNil(sound)
    }
    
    func testPokemon() {
        let test = [Pokemon]()
        XCTAssertNotNil(test)

    }
    
    func testPokemonViewModel() async throws {
        let viewModel = await PokemonViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider()))
        XCTAssertNotNil(viewModel)
        
        Task{
            await viewModel.loadAllData()
            let pokemon = await viewModel.pokemons
            let status = await viewModel.status
            let count = await viewModel.count
            let win = await viewModel.win
            
            XCTAssertNotNil(pokemon)
            XCTAssertNotNil(status)
            XCTAssertNotNil(count)
            XCTAssertNotNil(win)
        }
    }
    
    func testPokemonRow() throws{
        let view = PokemonRow(pokemonImageUrl: "", pokemonName: "")
        XCTAssertNotNil(view)
        
        let numItems = try view.inspect().count
        XCTAssertEqual(numItems, 1)
        
        let shape = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(shape)
        
        let shape2 = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(shape2)
        
        let shape3 = try view.inspect().find(viewWithId: 3)
        XCTAssertNotNil(shape3)
        
        let text = try view.inspect().find(viewWithId: 5)
        XCTAssertNotNil(text)
    }
    
    func testpokemonView() throws {
        let view = try PokemonView()
        XCTAssertNotNil(view)
    }
    
    @MainActor func testFinalView() throws {
        let view = FinalView().environmentObject(PokemonViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
        XCTAssertNotNil(view)
        
        let image = try view.inspect().find(viewWithId: 6)
        XCTAssertNotNil(image)
        
        let text2 = try view.inspect().find(viewWithId: 8)
        XCTAssertNotNil(text2)
    }

}

//
//  Challenge_iOS_B2WTests.swift
//  Challenge_iOS_B2WTests
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import XCTest

@testable import Challenge_iOS_B2W

class Challenge_iOS_B2WTests: XCTestCase {

    private var homeView            : HomeView?
    private var homeViewModel       : HomeViewModel = HomeViewModel()
    
    override func setUp() {
        super.setUp()
        homeView = HomeView(homeViewModel: homeViewModel, detailsViewModel: DetailsViewModel())
    }

    func testPokemonList() {
        let pokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        homeView?.homeViewModel.pokemonList.append(pokemon)
        XCTAssertEqual(homeView?.homeViewModel.pokemonList.count, 1)
    }
    
    func testReload() {
        homeView?.homeViewModel.reloadData()
        XCTAssertEqual(homeView?.homeViewModel.pokemonList.count, 0)
    }
    
    func testApiCall(){
        var nextPage                     : String = ""
        var pokemonList                  : [Pokemon] = []
        let expectation                  = expectation(description: "pokemon")
        
        PokemonService.getAllPokemons { results  in
            switch results {
            case .Success(let list, let url):
                nextPage = url
                pokemonList = list
                expectation.fulfill()
            case .Fail(let error):
                print("Error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(pokemonList)
        }
    }
}

//
//  Challenge_iOS_B2WTests.swift
//  Challenge_iOS_B2WTests
//
//  Created by Mariela Mendonça de Andrade on 13/07/21.
//

import XCTest

@testable import Challenge_iOS_B2W

class Challenge_iOS_B2WTests: XCTestCase {

    private var homeView: HomeView?
    
    override func setUp() {
        super.setUp()
        homeView = HomeView(homeViewModel: HomeViewModel(), detailsViewModel: DetailsViewModel())
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
}

//
//  Genres.swift
//  TastProfico
//
//  Created by Tomislav Jurić-Arambašić on 05/12/2020.
//

import Foundation

struct Game: Codable {
    let name: String
    let id: Int
}

struct Genre: Codable {
    let name: String
    let games: [Game]
    let id: Int
}

struct Genres: Codable {
    let count: Int
    let results: [Genre]
}

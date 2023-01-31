//
//  DataPokemon.swift
//  Pokedex
//
//  Created by Sanket Patel  on 2023-01-28.
//

import Foundation
struct Pokemon: Decodable ,Identifiable {
    let id:Int
    let attack:Int
    let name:String
    let defense:Int
    let description:String
    let type:String
    let imageUrl :String
}

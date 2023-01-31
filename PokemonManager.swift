//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Sanket Patel  on 2023-01-28.
//

import Foundation
protocol pokemonManagerDelegate {
    func showListPokemon(List: [Pokemon])
}

struct PokemonManger {
    
    var delegate : pokemonManagerDelegate?
    func seePokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data,response,error in
                if error !=  nil{
                    print("Error Getting Data From Api:",error?.localizedDescription)
                }
                if let dataInsurance = data?.parseData(removeString:"null,"){
                    if let listPokemon = self.parsearJSON(dataPokemon:dataInsurance){
                        print("List Pokemon: " ,listPokemon)
                        delegate?.showListPokemon(List: listPokemon)
                    }
                }
                    
                
            }
            task.resume()
        }
    }
    func parsearJSON(dataPokemon:Data) -> [Pokemon]? {
        let decoding = JSONDecoder()
        do{
            let dataDecoded = try decoding.decode([Pokemon].self, from: dataPokemon)
            return dataDecoded
        }catch{
            print("Error Decoding Data: ",error.localizedDescription)
            return nil
        }
    }
}
extension Data {
    func parseData(removeString words : String) -> Data?  {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: words, with: "")
        guard let dataDom = parseDataString?.data(using: .utf8)else{return nil}
        return dataDom
    }
}


//
//  DetailPokemonViewController.swift
//  Pokedex
//
//  Created by Sanket Patel  on 2023-01-28.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    var pokemonShow : Pokemon?
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionPokemon: UITextView!
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var defencePokemon: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        attackPokemon.text = "Attack: \(pokemonShow!.attack)"
        defencePokemon.text = "Defence: \(pokemonShow!.defense)"
        typePokemon.text = "Type : \(pokemonShow?.type ?? "")"
        descriptionPokemon.text = "\(pokemonShow?.description ?? "")"
        pokemonImage.loadFrom(URLAddres: pokemonShow?.imageUrl ?? "")
    }
    

}
extension UIImageView {
    func loadFrom(URLAddres:String) {
        guard let url = URL(string: URLAddres) else {return}
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self.image = loadedImage
            }
            
            }
        }
        
    }
}

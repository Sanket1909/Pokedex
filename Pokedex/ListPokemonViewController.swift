//
//  ViewController.swift
//  Pokedex
//
//  Created by Sanket Patel  on 2023-01-28.
//

import UIKit

class ListPokemonViewController: UIViewController {

    @IBOutlet weak var tabelPokemon: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    var pokemonManager = PokemonManger()
    
    var pokemons :[Pokemon] = []
    var pokemonSelected : Pokemon?
    var pokemonFilter : [Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelPokemon.register(UINib(nibName: "CellPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tabelPokemon.delegate = self
        tabelPokemon.dataSource = self
        pokemonManager.delegate = self
        searchBarPokemon.delegate = self
        pokemonManager.seePokemon()
      
        
        // Do any additional setup after loading the view.
    }


}

extension ListPokemonViewController:UISearchBarDelegate{
    func searchBar(_searchBar: UISearchBar, textDidChange searchText: String){
        pokemonFilter = []
        if searchText == "" {
            pokemonFilter = pokemons
        } else {
            for poke in pokemons {
                if poke.name.lowercased().contains(searchText.lowercased()){
                    pokemonFilter.append(poke)
                }
            }
        }
        self.tabelPokemon.reloadData()
    }
    
}
extension ListPokemonViewController:pokemonManagerDelegate {
    func showListPokemon(List: [Pokemon]) {
        pokemons = List
        DispatchQueue.main.async {
            self.pokemonFilter = List
            self.tabelPokemon.reloadData()
        }
    }
    
    
}

extension ListPokemonViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelPokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellPokemonTableViewCell
        cell.namePokemon.text = pokemonFilter[indexPath.row].name
        cell.attackLabel.text = "Attack: \(pokemonFilter[indexPath.row].attack)"
        cell.defenceLabel.text = "Defence: \(pokemonFilter[indexPath.row].defense)"
      
        if let urlString = pokemonFilter[indexPath.row].imageUrl as? String {
            if let imgUrl = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imgUrl) else
                    {return}
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imagePokemon.image = image
                    }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSelected = pokemonFilter[indexPath.row]
        performSegue(withIdentifier: "showPokemon", sender: self)
        tabelPokemon.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPokemon" {
            let showPokemon = segue.destination as! DetailPokemonViewController
            showPokemon.pokemonShow = pokemonSelected
        }
    }
    
    
}


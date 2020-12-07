//
//  ViewController.swift
//  TastProfico
//
//  Created by Tomislav Jurić-Arambašić on 05/12/2020.
//

import UIKit

class ViewController: UITableViewController {
    var response: Genres?
    let defaults = UserDefaults.standard
    var selectedGenres =  [String]()
    var dictToShow =  [String:Int]()
    
    var genreSelectionChanged: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(buttonTapped))
        navigationItem.title = "Select genres"
        getGenres()
        tableView.allowsMultipleSelection = true
    }
    
    func getGenres() {
        let url = "https://api.rawg.io/api/genres"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, _ , error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            //have data
            do {
                self.response = try JSONDecoder().decode(Genres.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch {
                print("failed to convert \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    @objc func buttonTapped() {
        selectedGenres.removeAll()
        //gamesToShow.removeAll()
        dictToShow.removeAll()
        if tableView.indexPathsForSelectedRows?.isEmpty != nil {
            for items in tableView.indexPathsForSelectedRows! {
                selectedGenres.append(response!.results[items.row].name)
                for game in response!.results[items.row].games {
                    //gamesToShow.append(game.name)
                    dictToShow.updateValue(game.id, forKey: game.name)
                }
            }
            defaults.set(selectedGenres,forKey: "SavedGenreArray")
            defaults.set(dictToShow,forKey: "SavedGameDict")
        }
        genreSelectionChanged?()
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let genres = response?.results[indexPath.row]
        cell.textLabel?.text = genres?.name
        return cell
    }
}


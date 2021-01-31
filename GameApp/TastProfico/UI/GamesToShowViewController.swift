//
//  DetailViewController.swift
//  TastProfico
//
//  Created by Tomislav Jurić-Arambašić on 06/12/2020.
//

import UIKit

class GamesToShowViewController: UITableViewController {
    var selectedGenreIds = UserDefaults.standard.array(forKey: "GenresID") as? [Int] ?? []
    var games = [Game]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .selectedGenresChanged , object: nil)
        
        self.navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(buttonTapped))
        
        if selectedGenreIds.count == 0 {
            performSegue(withIdentifier: "present", sender: self)
        } else {
            fetchGames()
        }
    }
    @objc func buttonTapped() {
        performSegue(withIdentifier: "present", sender: self)
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        selectedGenreIds = UserDefaults.standard.array(forKey: "GenresID") as! [Int]
        fetchGames()
        
    }
    
    func fetchGames() {
            guard var urlComps = URLComponents(string: "https://api.rawg.io/api/games") else { return }
            let genreIds = selectedGenreIds.map { String($0) }.joined(separator: ",")
        
            let querryItems = [URLQueryItem(name: "genres", value: genreIds), URLQueryItem(name: "page_size", value: "40")]
            
            urlComps.queryItems = querryItems
            
            guard let url = urlComps.url else { return }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let jsonDecoder = JSONDecoder()
                    do {
                        let gamesResponse = try jsonDecoder.decode(GamesResponse.self, from: data)
                        self.games = gamesResponse.results
                        self.tableView.reloadData()
                    } catch {
                }
                }
            }
            task.resume()
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let game = games[indexPath.row]
        cell.textLabel?.text = game.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "GameDescriptionViewController") as? GameDescriptionViewController {
            vc.gameID = games[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


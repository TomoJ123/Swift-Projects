//
//  ViewController.swift
//  TastProfico
//
//  Created by Tomislav Jurić-Arambašić on 05/12/2020.
//

import UIKit

class GenresSelectionViewController: UITableViewController {
    var response: Genres?
    let defaults = UserDefaults.standard
    var selectedGenres = UserDefaults.standard.stringArray(forKey: "SavedGenreArray") ?? []
    var genresID = [Int]()
    
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
            do {
                self.response = try JSONDecoder().decode(Genres.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("failed to convert \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    @objc func buttonTapped() {
        selectedGenres.removeAll()
        if tableView.indexPathsForSelectedRows?.isEmpty != nil {
            for items in tableView.indexPathsForSelectedRows! {
                selectedGenres.append(response!.results[items.row].name)
                genresID.append(response!.results[items.row].id)
            }
            defaults.set(selectedGenres,forKey: "SavedGenreArray")
            defaults.set(genresID,forKey: "GenresID")
            NotificationCenter.default.post(name: .selectedGenresChanged, object: nil, userInfo: nil)
        }
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let genre = response?.results[indexPath.row]
        cell.textLabel?.text = genre?.name
        if selectedGenres.contains(genre?.name ?? "") {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell
    }
}




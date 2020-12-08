//
//  DetailViewController.swift
//  TastProfico
//
//  Created by Tomislav Jurić-Arambašić on 06/12/2020.
//

import UIKit

class GamesToShowViewController: UITableViewController {
    var dictGamesToShow = UserDefaults.standard.dictionary(forKey: "SavedGameDict")
    var gameNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(buttonTapped))
        
        if dictGamesToShow?.isEmpty == nil {
            performSegue(withIdentifier: "present", sender: self)
        }
    }
    @objc func buttonTapped() {
        performSegue(withIdentifier: "present", sender: self)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictGamesToShow?.count ?? 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? GenresSelectionViewController {
            vc.genreSelectionChanged = { [weak self] in
                self?.dictGamesToShow = UserDefaults.standard.dictionary(forKey: "SavedGameDict")
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let names = dictGamesToShow?.keys {
            gameNames = Array(names)
            cell.textLabel?.text = gameNames[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "Description") as? GameDescriptionViewController {
        let name = gameNames[indexPath.row]
        vc.gameID = dictGamesToShow?[name] as? Int
        navigationController?.pushViewController(vc, animated: true)
        }
    }
}


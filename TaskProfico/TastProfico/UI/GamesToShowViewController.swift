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
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .selectedGenresChanged , object: nil)
        
        self.navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(buttonTapped))
        
        if dictGamesToShow?.isEmpty == nil {
            performSegue(withIdentifier: "present", sender: self)
        }
    }
    @objc func buttonTapped() {
        performSegue(withIdentifier: "present", sender: self)
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        dictGamesToShow = UserDefaults.standard.dictionary(forKey: "SavedGameDict")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictGamesToShow?.count ?? 1
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
        if let vc = storyboard.instantiateViewController(identifier: "GameDescriptionViewController") as? GameDescriptionViewController {
            let name = gameNames[indexPath.row]
            vc.gameID = dictGamesToShow?[name] as? Int
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


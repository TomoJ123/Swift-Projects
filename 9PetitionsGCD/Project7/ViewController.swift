//
//  ViewController.swift
//  Project7
//
//  Created by Tomislav Jurić-Arambašić on 25/10/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
        }
    
    @objc func fetchJSON() {
        let urlString: String
               
               let rightButton = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(buttonTapped))
               let leftButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions))
               
               self.navigationItem.leftBarButtonItem = leftButton
               self.navigationItem.rightBarButtonItem = rightButton
               
               if navigationController?.tabBarItem.tag == 0 {
                   urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
               }
               else {
                   urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
               }
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        parse(json: data)
                            return
                             }
                         }
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
               }
        
    @objc func filterPetitions() {
        let ac = UIAlertController(title: "Filter", message: "type string and it will filter all the partition so you can find that string in some petitions", preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "Search", style: .destructive) { [weak ac] (_) in
            let textField = ac?.textFields![0]
            let text: String = textField?.text ?? " "
            
//            print(textField!.text!)
            for petition in self.petitions {
                if petition.body.contains(text) {
                    self.filteredPetitions.append(petition)
                }
            }
            self.petitions = self.filteredPetitions
            self.tableView.reloadData()
        }
        ac.addAction(action)
        present(ac,animated: true)
    }
    
    @objc func buttonTapped() {
        let ac = UIAlertController(title: "Credits", message: "This is the link I uploaded all data:https://www.hackingwithswift.com/samples/petitions-1.json"
            , preferredStyle: .alert)
        let action = UIAlertAction(title: "cancel", style: .cancel)
        ac.addAction(action)
        present(ac,animated: true)
    }
    
   @objc func showError() {
        let ac = UIAlertController(title: "loading error", message: "There was an error loading the feed; please check connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
        }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
        else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController() //because no storyboard so we do it like this
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

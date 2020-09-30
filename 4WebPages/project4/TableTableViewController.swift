//
//  TableTableViewController.swift
//  project4
//
//  Created by Tomislav Jurić-Arambašić on 30/05/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    var websitesTable = ["apple.com", "hackingwithswift.com"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return websitesTable.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "URL", for: indexPath)
        cell.textLabel?.text = websitesTable[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "Web") as? ViewController {
            
            
            
            vc.selectedSite = websitesTable[indexPath.row] 
            navigationController?.pushViewController(vc, animated: true)
            //navVc.modalPresentationStyle = .fullScreen
            //present(navVc,animated: true)
        }
        
        }
    }



   

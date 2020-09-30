//
//  ViewController.swift
//  project4Milestone
//
//  Created by Tomislav Jurić-Arambašić on 16/05/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
   
    
    let imagesCell = [UIImage(named: "estonia"),
                      UIImage(named: "france"),
                      UIImage(named: "germany"),
                      UIImage(named: "ireland"),
                      UIImage(named: "italy"),
                      UIImage(named: "monaco"),
                      UIImage(named: "nigeria"),
                      UIImage(named: "poland"),
                      UIImage(named: "russia"),
                      UIImage(named: "spain"),
                      UIImage(named: "uk"),
                      UIImage(named: "us")]
    let nameCell = ["estonia","france","germany","ireland",
                    "italy","monaco","nigeria","poland",
                    "russia","spain","uk","us"]
    var pictures = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items
        {
            if item.hasSuffix("png")
            {
                pictures.append(item)
            }
        }
        print(pictures)
        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture" , for: indexPath)
        cell.textLabel?.text = nameCell[indexPath.row]
        cell.imageView?.image = imagesCell[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}


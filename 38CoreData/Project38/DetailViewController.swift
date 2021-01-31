//
//  DetailViewController.swift
//  Project38
//
//  Created by Tomislav Jurić-Arambašić on 04/12/2020.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var detailLabel: UILabel!
    var detailItem: Commit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detail = self.detailItem {
            detailLabel.text = detail.message
            //navigationitem.rightbarbuttonitem = uibarbttonitem(tittle: "commit 1/\(detail.author.commits.count)",style,target,action selector show author commits
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

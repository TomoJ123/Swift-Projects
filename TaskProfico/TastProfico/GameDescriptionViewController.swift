//
//  GameDescriptionViewController.swift
//  TastProfico
//
//  Created by Tomislav Jurić-Arambašić on 06/12/2020.
//

import UIKit

class GameDescriptionViewController: UIViewController {
    @IBOutlet var LabelGameInfo: UITextView!
    var gameID: Int?
    var response: GameDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGameDescription()
    }
    
    func getGameDescription() {
        let url = "https://api.rawg.io/api/games/\(gameID!)"
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, _ , error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            //have data
            do {
                self.response = try JSONDecoder().decode(GameDescription.self, from: data)
                DispatchQueue.main.async {
                    self.LabelGameInfo.text = self.response?.description.htmlToString
                    
                }
            }catch {
                print("failed to convert \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}


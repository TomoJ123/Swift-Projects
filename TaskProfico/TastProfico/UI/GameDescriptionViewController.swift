//
//  GameDescriptionViewController.swift
//  TastProfico
//
//  Created by Tomislav Jurić-Arambašić on 06/12/2020.
//

import UIKit

class GameDescriptionViewController: UIViewController {
    @IBOutlet var gameInfoTextView: UITextView!
    @IBOutlet var gameNameLabel: UILabel!
    @IBOutlet var gamePicture: UIImageView!
    @IBOutlet var gameRelaseDate: UILabel!
    var gameID: Int?
    var response: GameDetails?
    
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
            do {
                self.response = try JSONDecoder().decode(GameDetails.self, from: data)
                DispatchQueue.main.async {
                    self.gameInfoTextView.text = self.response?.description.htmlToString
                    self.gameNameLabel.text = self.response?.name
                    self.gameRelaseDate.text = "Released: \(self.response!.released)"
                    if let picture = self.response?.background_image {
                        let url = URL(string: picture)
                        let data = try? Data(contentsOf: url!)
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.gamePicture.image = image
                        }
                    }
                }
            } catch {
                print("failed to convert \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}


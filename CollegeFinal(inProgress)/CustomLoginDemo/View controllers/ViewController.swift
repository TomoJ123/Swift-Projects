//
//  ViewController.swift
//  CustomLoginDemo
//
//  Created by Tomislav Jurić-Arambašić on 20/09/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit
import AVKit
// napraviti log out button koji je vec bia napravljen !! i dalje windowe !!!
class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    //when View Controller is appeared,there is no navigation
    override func viewWillAppear(_ animated: Bool) {
        //set up video in the background
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setUpVideo()
    }
    //after viewcontroller it will appear in another controllers
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpVideo() {
        //get the path to the resource from bundle
       let bundlepath = Bundle.main.path(forResource: "loginback", ofType: "mp4")
        
        guard bundlepath != nil else {
            return
        }
        //make url from it
        let url = URL(fileURLWithPath: bundlepath!)
        
        //create a video player item
        let item = AVPlayerItem(url: url)
        //create a player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create a layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!,at: 0)
        
        //add it to view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
        
        
        
    }

}


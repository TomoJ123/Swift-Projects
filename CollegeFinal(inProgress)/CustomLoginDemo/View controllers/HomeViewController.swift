//
//  HomeViewController.swift
//  CustomLoginDemo
//
//  Created by Tomislav Jurić-Arambašić on 20/09/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddCar))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOutTapped))
        // Do any additional setup after loading the view.
    }
    
    
    @objc func logOutTapped() {
        guard let LoginScreen = storyboard?.instantiateViewController(identifier: Constants.Storyboard.viewController) as? ViewController else {return}
        
        LoginScreen.modalPresentationStyle = .fullScreen
        present(LoginScreen,animated: true)
    }
    
    @objc func AddCar() {
        guard let makeCar = storyboard?.instantiateViewController(identifier: Constants.Storyboard.CarViewController) as? CreateCarViewController else {return}
        
        present(makeCar,animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //it will be number of cars
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        return cell
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

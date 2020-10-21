//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Tomislav Jurić-Arambašić on 20/09/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetUpElements()
    }
    
    func SetUpElements() {
        
        //hide the error label
        errorLabel.alpha = 0
        
        
        //style the elements
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginTapped(_ sender: Any) {
        // Validate all fields and this down in else because its force unwrapping
        
        //cleaned versions of email and pass
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        //Sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // error with signing
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                //Transition to home screen
                guard let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController else { return }
//
//                self.view.window?.rootViewController = homeViewController
//                self.view.window?.makeKeyAndVisible()
        
                let navVC = UINavigationController(rootViewController: homeViewController)
                navVC.modalPresentationStyle = .fullScreen
                self.present(navVC, animated: true)
            }
     }
    }
    
    
    
}

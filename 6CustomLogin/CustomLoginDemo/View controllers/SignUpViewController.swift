//
//  SignUpViewController.swift
//  CustomLoginDemo
//
//  Created by Tomislav Jurić-Arambašić on 20/09/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements();

    }
    func setUpElements(){
        
        //Hide the error label
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstName)
        Utilities.styleTextField(lastName)
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(signUpButton)
        
    }
    // check the fields and validate that the data is correct. if everything is correct,this method returns nill. Otherwise , it returns the error message
    func validateFields() -> String?  {
        //check that all fields are filled in
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please fill in all fields."
        }
        
        //check if password is good , force unwrap it because i know there is something in it because it passed function validatefields
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //password is not secure enough
            return "Please make sure your password 8 char,contains special character and a number."
        }
        
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            // somewhere is error,show error message
            showError(error!)
        }
        else {
            //create cleaned version of data
            let firstname = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emaill = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user
            Auth.auth().createUser(withEmail: emaill, password: passwordd) { (result, err) in
                
                //check for errors
                if err != nil {
                    //there was an error creating user
                    self.showError("error creating user")
                }
                else {
                    // user created succesfully,now store first name last name
                    let db = Firestore.firestore()
                    
                    
                    db.collection("users").addDocument(data:  ["firstname":firstname , "lastname":lastname , "uid":result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //show error message
                            self.showError("user data not found , first name last name not saved,some problem with saving")
                        }
                        
                    }
                    
                    //Transition to the home screen
                
                    self.transitionToHome()
                }
            }
            
        }
        
    }
    
    
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha=1
    }
    
    func transitionToHome() {
        // or i could yust go HomeVC
        guard let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController else { return }
        
//        view.window?.rootViewController = homeViewController
//        view.window?.makeKeyAndVisible()
        let navVC = UINavigationController(rootViewController: homeViewController)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
        
    }
}

//
//  LoginViewController.swift
//  Instagram
//
//  Created by Denny Ho on 10/1/18.
//  Copyright © 2018 Denny Ho. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Sign In button pressed
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!)
        { (user: PFUser?, error: Error?) in
            
            if user != nil {
                print("you're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    //Sign Up Button
    @IBAction func onSignUp(_ sender: Any)
    {
        let newUser = PFUser()
        newUser.username = usernameField.text!
        newUser.password = passwordField.text!
        
        newUser.signUpInBackground {
            (success: Bool, error: Error?) in
            if success
            {
                print("created user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print("Error:")
                print(error!.localizedDescription)
                print(error.debugDescription)
                
            }
        }
    }
}

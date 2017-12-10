//
//  LoginViewController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 10-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginAction(_ sender: UIButton) {
        // Kijk of de velden voor email en wachtwoord ingevuld zijn.
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            // Login user
            if segmentControll.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    // Inloggen is goed gegaan:
                    if user != nil {
                        self.performSegue(withIdentifier: "loginComplete", sender: self)
                        print("-- LOGIN SUCCES --")
                        
                    }
                        // Gebruiker bestaat niet of andere login error:
                    else {
                        if let myError = error?.localizedDescription {
                            print(myError)
                        }
                        else {
                            print("--- ERROR IN LOGING ---")
                        }
                    }
 
                })
            }
             // Sign up user
            else {
                Auth.auth().createUserAndRetrieveData(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if user != nil {
                        print("-- LOGIN SUCCES --")
                    }
                    else {
                        if let myError = error?.localizedDescription {
                            print(myError)
                        }
                        else {
                            print("--- ERROR IN LOGING ---")
                        }

                    }
                })
            }
        }
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Extentions:
    
}

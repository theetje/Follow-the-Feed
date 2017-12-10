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
    
    // OUTLETS:
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var reEnterLabel: UILabel!
    @IBOutlet weak var reEnterTextField: UITextField!
    @IBOutlet weak var reEnterUnderline: UIView!
    
    // ACTIONS:
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
                            let alertController = UIAlertController(title: "Login Faild", message: "\(myError)", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        else {
                            let alertController = UIAlertController(title: "Oeps", message: "loggin faild.", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                            print("--- ERROR IN LOGING ---")
                        }

                    }
 
                })
            }
             // Als Register is ingedrukt, sign up user
            else {
                // Zolang de wachtwoorden 2 keer goed worden ingevuld:
                if passwordTextField.text == reEnterTextField.text {
                    Auth.auth().createUserAndRetrieveData(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                        if user != nil {
                            self.performSegue(withIdentifier: "loginComplete", sender: self)
                            print("-- LOGIN SUCCES --")
                        }
                        else {
                            if let myError = error?.localizedDescription {
                                print(myError)
                                let alertController = UIAlertController(title: "Registering Faild", message: "\(myError)", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                            else {
                                print("--- ERROR IN LOGING ---")
                                let alertController = UIAlertController(title: "Oeps", message: "Registering Faild", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    })
                }
                else {
                    // Dan is het wachtwoord verschilend
                    print("-- PASSWORD RE-ENTER ERROR --")
                    let alertController = UIAlertController(title: "Registering Faild", message: "Enter the same password twice", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
     }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if segmentControll.selectedSegmentIndex == 0 {
            loginButton.setTitle("LOGIN", for: .normal)
            reEnterLabel.isHidden = true
            reEnterTextField.isHidden = true
            reEnterUnderline.isHidden = true
        }
        else {
            loginButton.setTitle("REGISTER", for: .normal)
            reEnterLabel.isHidden = false
            reEnterTextField.isHidden = false
            reEnterUnderline.isHidden = false
        }
    }
    
    
    // FUNCTIONS:
    override func viewDidLoad() {
        super.viewDidLoad()
        reEnterLabel.isHidden = true
        reEnterTextField.isHidden = true
        reEnterUnderline.isHidden = true
        
        // Deze delegate is nodig om toetsenbord weg te laten gaan:
        emailTextField.delegate = self
        passwordTextField.delegate = self
        reEnterTextField.delegate = self
    }
    
    // Functie die keyBoard laat verdwijnen.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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

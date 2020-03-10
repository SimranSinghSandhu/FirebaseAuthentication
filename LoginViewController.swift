//
//  ViewController.swift
//  FirebaseAuthentication
//
//  Created by Simran Singh Sandhu on 09/03/20.
//  Copyright © 2020 Simran Singh Sandhu. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SVProgressHUD

class LoginViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically Sign in Google User.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        // Automatically Signing In if Not Signed Out from Previous Account
        if Auth.auth().currentUser != nil {
            SegueToDestinationViewController()
        }
        
        // Add Gestures on ContentView to Hide Keybord whn Pressed outside TextFields
        addingGesture()
    }

    // Tap Gesture Recognizer
    private func addingGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(contentViewHandle(sender:)))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    // When Tapped on Content View (To Hide Keyboard)
    @objc func contentViewHandle(sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // When LoginButton is Pressed
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        // Take Data from Email and Password Textfield to Login in app.
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            
            if error != nil {
                // Error
                print("Error = ", error!)
                SVProgressHUD.dismiss()
            } else {
                // SuccessFull
                print("Successfully logged In!")
                SVProgressHUD.dismiss()
                self.SegueToDestinationViewController()
            }
        }
    }
    
    // When GoogleSignInButton is pressed.
    @IBAction func googleSignInButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    // When Sign is successful, take the user to SignOut Page to Show some User Details.
    private func SegueToDestinationViewController() {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SignOutViewController") as! SignOutViewController
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

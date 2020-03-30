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
import FBSDKCoreKit
import FBSDKLoginKit
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

extension LoginViewController {
    
    // Facebook Login using Custom Button.
    @IBAction func facebookSignInButtonPressed(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Signing Into Facebook")
        // Creating a Instance of Manager
        let manager = LoginManager()
        // Asking for Permissions from user
        manager.logIn(permissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
           if error != nil {
                // Error
                print("Error =", error!)
                SVProgressHUD.dismiss()
           } else if result!.isCancelled {
                // If User Cancelled the Facebook Login Midway
                print("Cancelled")
                SVProgressHUD.dismiss()
           } else { // If User Successfully Login To Facebook
            
                print("Logged Into Facebook!")
                print("Declined Permission =", result!.declinedPermissions) // Nil if all Permission are granted (Array)
                print("Granted Permission =", result!.grantedPermissions)   // Nil if all Permission are Declined (Array)
            
                guard let token = AccessToken.current?.tokenString else {return}
                
                print("Token = ", token)
            
                // Sending TokenString to LogInto Firebase using Facebook.
                self.signingIntoFirebase(with: token)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    // Signing Into Firebase using Facebook Token
    private func signingIntoFirebase(with facebookToken: String) {
        
        SVProgressHUD.show(withStatus: "Wait")
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: facebookToken)
           
        // Signing in using Credentials
        Auth.auth().signIn(with: credentials) { (result, error) in
            if error != nil {
                // Error
                print("Error =", error!)
                SVProgressHUD.dismiss()
            } else {
                // Login Sucessfull
                print("User Signed Into Firebase using Facebook")
                self.SegueToDestinationViewController()
                SVProgressHUD.dismiss()
            }
        }
    }
}

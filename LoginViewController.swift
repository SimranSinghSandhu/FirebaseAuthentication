//
//  ViewController.swift
//  FirebaseAuthentication
//
//  Created by Simran Singh Sandhu on 09/03/20.
//  Copyright © 2020 Simran Singh Sandhu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addingGesture()
    }

    private func addingGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(contentViewHandle(sender:)))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func contentViewHandle(sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            
            if error != nil {
                print("Error = ", error!)
                SVProgressHUD.dismiss()
            } else {
                print("Successfully logged In!")
                SVProgressHUD.dismiss()
                self.SegueToDestinationViewController()
            }
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
    }
    
    private func SegueToDestinationViewController() {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SignOutViewController") as! SignOutViewController
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}


//
//  RegistrationViewController.swift
//  FirebaseAuthentication
//
//  Created by Simran Singh Sandhu on 09/03/20.
//  Copyright © 2020 Simran Singh Sandhu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Sign Up Using Email and Password
    @IBAction func signUpButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error != nil {
                print("Error = ", error!)
                SVProgressHUD.dismiss()
            } else {
                print("Registration Compelete.")
                SVProgressHUD.dismiss()
                self.SegueToDestinationViewController()
            }
        }
    }
    
    // Segue to SignOut View COntroller When user Registered Sucessfully.
    private func SegueToDestinationViewController() {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SignOutViewController") as! SignOutViewController
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

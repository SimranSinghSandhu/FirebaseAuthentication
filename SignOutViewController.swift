//
//  SignOutViewController.swift
//  FirebaseAuthentication
//
//  Created by Simran Singh Sandhu on 09/03/20.
//  Copyright © 2020 Simran Singh Sandhu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    @IBAction func signOutButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        do {
            try Auth.auth().signOut()
            SVProgressHUD.dismiss()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error =", error)
            SVProgressHUD.dismiss()
        }
    }
    
    
}

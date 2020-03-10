//
//  SignOutViewController.swift
//  FirebaseAuthentication
//
//  Created by Simran Singh Sandhu on 09/03/20.
//  Copyright © 2020 Simran Singh Sandhu. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import Kingfisher
import SVProgressHUD

class SignOutViewController: UIViewController {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
        // Get UserDetails when View Loads (GoogleSignedInOnly)
        gettingCurrentUserDetails()
        
    }

    // Getting Logged In User Details (Name and Profile Picture URL) (GoogleSignedInOnly)
    private func gettingCurrentUserDetails() {
        let user = Auth.auth().currentUser
        
        // Setting the Profile Pic of the Google Account Holder into UIImageView
        if let profilePictureURL = user?.photoURL {
            profilePictureImageView.kf.setImage(with: profilePictureURL)
        }
        // Showing Display Name of Google Account Holder in Label
        if let displayName = user?.displayName {
            displayNameLabel.text = displayName
        }
    }
    
    // Sign Out from Firebase.
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

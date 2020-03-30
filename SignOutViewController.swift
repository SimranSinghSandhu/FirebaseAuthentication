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
        
        // Making the ImageView Circle. To make it a perfect Circle set your object with same height and Width and give cornerRadius of that object a value which will be half of the object's height or width.
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        
        // Get UserDetails when View Loads (GoogleSignedInOnly)
        gettingCurrentUserDetails()
        
    }

    // Getting Logged In User Details (Name and Profile Picture URL) (GoogleSignedInOnly)
    private func gettingCurrentUserDetails() {
        let user = Auth.auth().currentUser
        
        // Setting the Profile Pic of the Google Account Holder into UIImageView
        if let profilePictureURL = user?.photoURL {
//            profilePictureImageView.kf.setImage(with: profilePictureURL)
            
           
            let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.profilePictureImageView.frame.size.width * UIScreen.main.scale, height: self.profilePictureImageView.frame.size.height * UIScreen.main.scale))
            
            profilePictureImageView.kf.setImage(with: profilePictureURL, placeholder: nil, options: [.processor(resizingProcessor)], progressBlock: nil, completionHandler: nil)
            
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

extension UIImage {
    
    
    class func scaleImageToSize(img: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        img.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
}

//
//  PhoneNumberViewController.swift
//  FirebaseAuthentication
//
//  Created by Simran Singh Sandhu on 14/03/20.
//  Copyright © 2020 Simran Singh Sandhu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PhoneNumberViewController: UIViewController {

    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    // This OTP is registerd in Firebase with Phone Number +91 1234567890
    let otp = "123123" // Dummy OTP
    
    // Can manually Add this Number or HardCode it for testing
    let phoneNum = "+911234567890" // Dummy Phone Number

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    // Phone Button will send OTP to your phone.
    @IBAction func phoneBtnPressed(_ sender: Any) {
        SVProgressHUD.show()
        // For Testing purpose Only.
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        guard let phoneNumber = phoneNumberTextField.text else { return }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                print("Error =", error!)
                SVProgressHUD.dismiss()
            } else {
                print("Verification ID =", verificationID!)
                UserDefaults.standard.set(verificationID!, forKey: "verificationID")
                SVProgressHUD.dismiss()
            }
        }
    }
    
    // Verify Button will verify if the OTP is correct and If correct it will Sign into the app.
    @IBAction func verifyBtnPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        guard let verificationID = UserDefaults.standard.string(forKey: "verificationID") else {return}
        
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
        
        Auth.auth().signIn(with: credentials) { (result, error) in
            if error != nil {
                print("Error =", error!)
                SVProgressHUD.dismiss()
            } else {
                print("Signed-In Successful!")
                SVProgressHUD.dismiss()
                self.segueToDestinationViewController()
            }
        }
    }
    
    private func segueToDestinationViewController() {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SignOutViewController") as! SignOutViewController
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

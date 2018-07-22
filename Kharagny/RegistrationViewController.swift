//
//  RegistrationViewController.swift
//  Kharagny
//
//  Created by Mohamed Sherif on 7/18/18.
//  Copyright © 2018 Gorgov. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBAction func register(_ sender: Any) {
        if (txtPassword.text != txtPassword2.text){
            
        } else {
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (authData, err) in
                if err != nil {
                    print("Error \(err)")
                } else {
                    print("Success! \(authData)")
                }
            }
        }
    }
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPassword2: UITextField!
}

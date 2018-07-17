//
//  ViewController.swift
//  Kharagny
//
//  Created by Mohamed Sherif on 7/10/18.
//  Copyright © 2018 Gorgov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var firebaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("HQWeqew")
        signinButton.layer.cornerRadius = 30
        txtUsername.text = nil
        txtPassword.text = nil
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        txtUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        firebaseReference.child("test1").child("sub-test1").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
        })
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//
//        textField.resignFirstResponder()
//        //or
//        //self.view.endEditing(true)
//        return true
//    }


}


//
//  ViewController.swift
//  Kharagny
//
//  Created by Mohamed Sherif on 7/10/18.
//  Copyright © 2018 Gorgov. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate{
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err ?? "")
                return
            } else {
                print("Success \(result)")
                let accessToken = FBSDKAccessToken.current()
                guard let accessTokenString = accessToken?.tokenString else { return }
                print("Access Token string\(accessTokenString)")
                let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
                Auth.auth().signInAndRetrieveData(with: credentials, completion: { (user, error) in
                    if error != nil {
                        print("Something went wrong with our FB user: ", error ?? "")
                        return
                    }
                    
                    print("Successfully logged in with our user: ", user ?? "")
                })

            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signinButton.layer.cornerRadius = signinButton.layer.frame.height / 2
//        txtUsername.text = nil
//        txtPassword.text = nil
//        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
//        txtUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
//
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("In Delegate!!")
        if error != nil {
            print("Error! \(error)")
        } else {
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else { return }
            print("Access Token string\(accessTokenString)")
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signInAndRetrieveData(with: credentials, completion: { (user, error) in
                if error != nil {
                    print("Something went wrong with our FB user: ", error ?? "")
                    return
                }
                
                print("Successfully logged in with our user: ", user ?? "")
            })
        }
    }
    @IBAction func emailLogin(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtUsername.text!, password: txtPassword.text!) { (user, error) in
            if error != nil {
                print("Error !\(error)")
            }
            print("Logged In!")
        }
    }
}


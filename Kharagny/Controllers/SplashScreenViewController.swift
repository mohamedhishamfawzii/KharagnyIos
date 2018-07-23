//
//  SplashScreenViewController.swift
//  Kharagny
//
//  Created by Mohamed Sherif on 7/16/18.
//  Copyright © 2018 Gorgov. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SplashScreenViewController: UIViewController,  FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        loginButton.layer.cornerRadius = loginButton.layer.bounds.height / 2
        signupButton.layer.cornerRadius = signupButton.layer.bounds.height / 2
        // Do any additional setup after loading the view.
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
                    self.performSegue(withIdentifier: "3rdPartySegue", sender: nil)
                    print("Successfully logged in with our user: ", user ?? "")
                })
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

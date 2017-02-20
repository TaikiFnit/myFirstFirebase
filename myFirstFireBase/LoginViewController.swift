//
//  LoginViewController.swift
//  myFirstFireBase
//
//  Created by TaikiFnit on 2017/02/08.
//  Copyright © 2017年 TaikiFnit. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var ref:FIRDatabaseReference?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextFIeld: UITextField!

    @IBAction func pushLoginButton(_ sender: UIButton) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextFIeld.text!) { (user, error) in
            print(user)
            print(error)
            
            if (user != nil) {
                let next = self.storyboard!.instantiateViewController(withIdentifier: "realtimeDatabase")
                self.present(next, animated: true, completion: nil)
            }
            else {
                print("error!")
                print(error)
            }
        }
    }
    
    @IBAction func pushCreateButton(_ sender: UIButton) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ref = FIRDatabase.database().reference()
        
        if let user = FIRAuth.auth()?.currentUser {
            // user is signed in.
            let next = self.storyboard!.instantiateViewController(withIdentifier: "realtimeDatabase")
            self.present(next, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

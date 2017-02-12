//
//  signUpViewController.swift
//  myFirstFireBase
//
//  Created by TaikiFnit on 2017/02/08.
//  Copyright © 2017年 TaikiFnit. All rights reserved.
//

import UIKit
import Firebase

class signUpViewController: UIViewController {
    
    let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushCreateButton(_ sender: UIButton) {
        
        let email:String = emailTextField.text!
        let password:String = passwordTextField.text!
        
        // trailing closures
        // .createUser(arg1, arg2: arg2, completion: { (user, error) in ... }) equals .createUser(arg1, arg2: arg2) { (user, error) in ... }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            
//            print("user")
//            print(user)
//            print("errror")
//            print(error)
//            print("user?.displayName")
//            print(user?.displayName)
//            print(user?.email)
//            print(user?.uid)
//            print(user.debugDescription)
//            print(user?.isEmailVerified)
//            print(user?.isAnonymous) // is匿名
            
            let next = self.storyboard!.instantiateViewController(withIdentifier: "realtimeDatabase")
            self.present(next, animated: true, completion: nil)
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

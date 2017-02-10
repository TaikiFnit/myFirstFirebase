//
//  ViewController.swift
//  myFirstFireBase
//
//  Created by TaikiFnit on 2017/01/24.
//  Copyright © 2017年 TaikiFnit. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.ref = FIRDatabase.database().reference()
        
        textView.delegate = self
        textField.delegate = self
        
        textLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.text = textView.text + textField.text! + "\n"
        textField.text = ""
        
        textField.resignFirstResponder()
        
        save()
        
        return true
    }

    func save() {
        //self.ref.child("text").setValue(["str": self.textView.text])
    }
    
    func textLoad() {
        
//        self.ref.child("text").observe(.value, with: {(snapShots) in
//            if snapShots.children.allObjects is [FIRDataSnapshot] {
//                print("snapShots")
//                print(snapShots.childSnapshot(forPath: "str"))
//                self.textView.text = "\(snapShots.childSnapshot(forPath: "str").value!)"
//            }
//        })
    }
    
    @IBAction func send(_ sender: UIButton) {
        textView.text = textView.text + textField.text! + "\n"
        textField.text = ""
        save()
    }

    @IBAction func clear(_ sender: UIButton) {
        textView.text = ""
        save()
    }
}


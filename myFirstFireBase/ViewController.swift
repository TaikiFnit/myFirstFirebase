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
    
    let ref = FIRDatabase.database().reference()
    var user: FIRUser?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textField.delegate = self
        
        user = FIRAuth.auth()?.currentUser
        nameLabel.text = "Signed in as " + (user?.email)!
        

        self.ref.child("posts").child(user!.uid).observeSingleEvent(of: .value, with: { (snapShot) in
            
            for rest in snapShot.children.allObjects as! [FIRDataSnapshot] {
                //self.showComment(rest: rest)
            }
            
        })
        
        observeTextEvent()
    }
    
    func showComment(rest:FIRDataSnapshot) {
        // restはsnapShot型なので、value methodで値を取り出せる.
        let comment = rest.value as! NSDictionary
        let text = comment["text"] as! String
        
        // storeされているのは timestampなので、これをdateに変換してやる
        let timeStamp = NSDate(timeIntervalSince1970: ((comment["timestamp"] as! Double) / 1000.0))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.ReferenceType.local
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        
        let time = dateFormatter.string(from: timeStamp as Date)
        
        self.textView.text = self.textView.text + time + " : " + text + "\n"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        save(text: textField.text!)
        textField.text = ""
        
        textField.resignFirstResponder()
        
    
        return true
    }

    func save(text: String) {
        self.ref.child("posts").child(user!.uid).childByAutoId().setValue(["text": text, "timestamp": FIRServerValue.timestamp() ])
    }
    
    func observeTextEvent() {
        self.ref.child("posts").child(user!.uid).observe(.childAdded, with: { (snapShot) in
            self.showComment(rest: snapShot)
            // observeのevent type が .childAdded ではなく .valueの際は、snapShotの連想配列なので、for を使用して個別にsnapShotを取り出す必要がある.
//            for rest in snapShot.children.allObjects as! [FIRDataSnapshot] {
                //self.showComment(rest: rest)
//                print(rest)
//            }
        })
        
        self.ref.child("posts").child(user!.uid).observe(.childRemoved, with: { (snapShot) in
            self.textView.text = ""
            
            self.ref.child("posts").child(self.user!.uid).observeSingleEvent(of: .childAdded, with: { (snapShot) in
                self.showComment(rest: snapShot)
            })
        })
    }
    
    @IBAction func send(_ sender: UIButton) {

    }

    @IBAction func clear(_ sender: UIButton) {
        self.ref.child("posts").child(user!.uid).removeValue()
        self.textView.text = ""
    }
}


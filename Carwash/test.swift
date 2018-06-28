//
//  test.swift
//  Carwash
//
//  Created by Mukhamedjan on 24.06.18.
//  Copyright © 2018 sdu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class test: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpBtn.layer.cornerRadius = 5
        cancelBtn.layer.cornerRadius = 5
        
        ref = FIRDatabase.database().reference()
        
        do {
            try FIRAuth.auth()?.signOut()
            print("EVERYTHING IS FINE")
        } catch  {
            print("There was a problem")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil{
            self.presentLoggedInScreen()
        }
    }
    
    func presentLoggedInScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "test", bundle: nil)
        let loggedVC:LoggedVC = storyboard.instantiateViewController(withIdentifier: "LoggedVC") as! LoggedVC
        self.present(loggedVC, animated: true, completion: nil)
    }
    
    
    @IBAction func registrTapped(_ sender: Any) {
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if error == nil{
                    self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("name").setValue(self.firstName.text!)
                    self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("lastName").setValue(self.lastName.text!)
                    self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("Phone").setValue(self.phone.text!)
                    self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("email").setValue(self.emailField.text!)
                    
                        print("FIIIIIIIIIIINE")
                        self.performSegue(withIdentifier: "goBack", sender: nil)
                }
                else{
                    let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let alert_action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(alert_action)
                    self.present(alert, animated: true, completion: nil)
                }
                print("success")
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

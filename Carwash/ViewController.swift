//
//  ViewController.swift
//  Carwash
//
//  Created by Mukhamedjan on 23.06.18.
//  Copyright © 2018 sdu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil{
            self.presentLoggedInScreen()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LoginTapped(_ sender: Any) {
        if let email = emailText.text, let password = passText.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil{
                    self.presentLoggedInScreen()
                }
                else {
                    let alert = UIAlertController(title: " ", message: "Incorrect email or password", preferredStyle: .alert)
                    let alert_action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(alert_action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

    func presentLoggedInScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedVC:LoggedVC = storyboard.instantiateViewController(withIdentifier: "LoggedVC") as! LoggedVC
        self.present(loggedVC, animated: true, completion: nil)
    }

}


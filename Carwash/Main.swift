//
//  Main.swift
//  Carwash
//
//  Created by Mukhamedjan on 23.06.18.
//  Copyright © 2018 sdu. All rights reserved.
//

import UIKit
import FirebaseAuth

class Main: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var carsPicker: UIPickerView!
    var cars:[[String]] = [["Хэтчбек/Седан", "Кроссовер", "Джип"],["Салон + Кузов", "Кузов", "Салон"]]
    var selected_car:String = String()
    var typeOfWash:String = String()
    
    @IBAction func logout(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            print("EVERYTHING IS FINE")
            self.presentLoggedInScreen()
        } catch  {
            print("There was a problem")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return cars[0].count
        }
        else{
            return cars[1].count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cars[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_car = cars[0][pickerView.selectedRow(inComponent: 0)]
        typeOfWash = cars[1][pickerView.selectedRow(inComponent: 1)]
    }
    
    func presentLoggedInScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController1:ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(viewController1, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromPicker"{
            if let destination = segue.destination as? typeOfWash{
                if (selected_car == "" && typeOfWash == ""){
                    selected_car=cars[0][0]
                    typeOfWash=cars[1][0]
                }
                destination.typeOfCar = selected_car
                destination.typeOfWash = typeOfWash
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

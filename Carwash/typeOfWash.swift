//
//  typeOfWash.swift
//  Carwash
//
//  Created by Mukhamedjan on 25.06.18.
//  Copyright © 2018 sdu. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class typeOfWash: UIViewController {
    
    @IBOutlet var map: MKMapView!
    
    var typeOfCar:String = String()
    var typeOfWash:String = String()
    
    var AlmatyLong:Double = 76.9286100;
    var AlmatyLat:Double = 43.2566700;
    
    var ref: FIRDatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        map.mapType = MKMapType.hybrid
        
        print(typeOfCar)
        print(typeOfWash)
        
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(AlmatyLat), longitude: CLLocationDegrees(AlmatyLong))
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Almaty"
        annotation.subtitle = "city"
        
        map.addAnnotation(annotation)
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.2, 0.2)
        let loc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(AlmatyLat),CLLocationDegrees(AlmatyLong))
        let region:MKCoordinateRegion = MKCoordinateRegionMake(loc, span)
        
        map.setRegion(region, animated: true)
        
        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(handleTap))
        
        uilgr.minimumPressDuration = 0.5
        
        map.addGestureRecognizer(uilgr)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: map)
        let coordinate = map.convert(location,toCoordinateFrom: map)
        
        let alert = UIAlertController(title: "Add place", message: "Write street", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField2) in
            textField2.placeholder = "Abay street"
        }
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
            let textField2 = alert.textFields![0]
            self.insertNewObject(textField2.text!, coordinate.latitude, coordinate.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Almaty"
            annotation.subtitle = textField2.text
            self.map.addAnnotation(annotation)
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    func insertNewObject(_ subtitle:String, _ latitude:Double, _ longtitude:Double) {
            self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("coordinate").child("latitude").setValue(latitude)
        self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("coordinate").child("longtitude").setValue(longtitude)
        
            self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("coordinate").child("subtitle").setValue(subtitle)
        
        
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

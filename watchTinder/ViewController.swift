//
//  ViewController.swift
//  watchTinder
//
//  Created by guillaume hammadi on 12/02/2015.
//  Copyright (c) 2015 reaHack. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var latValue : String = ""
    var longValue : String = ""

    @IBOutlet weak var longitude : UILabel!
    @IBOutlet weak var latitude : UILabel!
    @IBOutlet weak var propertyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func findMyLocation(sender: AnyObject) {
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func sendHttpRequest(sender: AnyObject) {
        Property.fetch(latValue, long: longValue)
    }
    
    // Delegates for CLLocationManager
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        if !placemark.isEqual(nil) {
            var currentLocation  = placemark.location
            
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            latValue = currentLocation.coordinate.latitude.description
            self.latitude.text = currentLocation.coordinate.latitude.description
            
            longValue = currentLocation.coordinate.longitude.description
            self.longitude.text = currentLocation.coordinate.longitude.description
            
            println("longitude: \(currentLocation.coordinate.longitude)")
            println("latitude: \(currentLocation.coordinate.latitude)")
        }

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


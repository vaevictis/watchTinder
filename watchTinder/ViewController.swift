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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func findMyLocation(sender: AnyObject) {
        println("location pushed")
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        println("location update started")
    }
    
    // Delegates for CLLocationManager
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            println(placemarks)
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        println("in displayLocationInfo")
        println(placemark)
        if !placemark.isEqual(nil) {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            println(placemark.locality.isEmpty ? "" : placemark.locality)
            println(placemark.postalCode.isEmpty ? "" : placemark.postalCode)
            println(placemark.administrativeArea.isEmpty ? "" : placemark.administrativeArea)
            println(placemark.country.isEmpty ? "" : placemark.country)
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


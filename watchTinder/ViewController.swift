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
    
    @IBAction func findMyLocation(sender: AnyObject) {
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        var localNotification:UILocalNotification = UILocalNotification()
        println("allez!")
        localNotification.alertAction = "Testing notifications on iOS8"
        localNotification.alertBody = "Woww it works!!"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    @IBAction func sendHttpRequest(sender: AnyObject) {
        // Make that asynchronous.
        // Printing the image has to wait for the property to actually be fetched.
        
        Property.fetch(self.printImage)
    }
    
    
    func printImage(imageURL: String!) {
        println("image url: \(imageURL)")

        let url = NSURL(string: imageURL)

        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            
            (data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }

        task.resume()

        let data = NSData(contentsOfURL: url!)
        propertyImage.image = UIImage(data: data!)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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


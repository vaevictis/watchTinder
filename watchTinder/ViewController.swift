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
        let url = NSURL(string: "http://i4.au.reastatic.net/1010x570/ae1391f68762a68214342239581e3ade381554376684c119caf1bd25a6ccdcaf/main.jpg")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
                println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
        
        let data = NSData(contentsOfURL: url!)
        propertyImage.image = UIImage(data: data!)
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
            self.latitude.text = currentLocation.coordinate.latitude.description
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


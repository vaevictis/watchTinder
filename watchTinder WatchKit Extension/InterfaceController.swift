//
//  InterfaceController.swift
//  watchTinder WatchKit Extension
//
//  Created by guillaume hammadi on 13/02/2015.
//  Copyright (c) 2015 reaHack. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var propertyImage: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let property: () = Property.fetch(self.printImageOnWatch)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func printImageOnWatch(imageURL: String!) {
        println("image url: \(imageURL)")
        
        let url = NSURL(string: imageURL)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            
            (data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
        
        let data = NSData(contentsOfURL: url!)
        propertyImage.setImage(UIImage(data: data!))
    }

}

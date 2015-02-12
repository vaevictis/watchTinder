//
//  Property.swift
//  watchTinder
//
//  Created by guillaume hammadi on 12/02/2015.
//  Copyright (c) 2015 reaHack. All rights reserved.
//

import Foundation

class Property {
    var name : String = ""
    var imageURL : String = ""
    
    
    class func fetch(var lat : String, var long : String) -> Property {
        println("fetch")
        let url = NSURL(string: "https://dummy-properties.herokuapp.com/property")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            println("data: \(data)")
        })
        
        return Property()
    }
    
}
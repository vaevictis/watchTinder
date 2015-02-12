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
    
    
    class func fetch(completionHandler: ((String!) -> Void)?) {
        println("fetch")
        var property = Property()

        DataManager.getDataFromApiWithSuccess { (propertiesData) -> Void in
            let json = JSON(data: propertiesData)
            
            if let propertyName = json["name"].stringValue as String? {
                println("SwiftyJSON: \(propertyName)")
                property.name = propertyName
            }
            
            if let propertyImage = json["image"].stringValue as String? {
                println("SwiftyJSON: \(propertyImage)")
                property.imageURL = propertyImage
            }
            
            completionHandler?(property.imageURL)
        }
        
    }
    
}
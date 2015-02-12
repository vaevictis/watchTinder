//
//  DataManager.swift
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Edited by Guillaume Hammadi on 02/12/15.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation

let dataURL = "https://dummy-properties.herokuapp.com/property"

class DataManager {
    
    class func getDataFromApiWithSuccess(success: ((propertiesData: NSData!) -> Void)) {
        loadDataFromURL(NSURL(string: dataURL)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(propertiesData: urlData)
            }
        })
    }
    
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"au.com.realestate", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}
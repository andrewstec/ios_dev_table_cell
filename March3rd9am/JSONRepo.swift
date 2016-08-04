
//
//  JSONRepoViewController.swift
//  March3rd9am
//
//  Created by Andrew Stec on 2016-03-01.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import UIKit

class JsonRepo: UIViewController {
    
    // Get the data asynchronously.
    // AnyObject means it can be called from any class.
    func getJSONData(url:String, sender: AnyObject?) {
        
        
        let url:NSURL = NSURL(string: url)!
        let session   = NSURLSession.sharedSession()
        let request   = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let task = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response
                where error == nil else {
                    print("error")
                    return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let json = NSString(data: data!,
                    encoding: NSASCIIStringEncoding)
                self.extractData(json!,sender:sender)
                return
            })
        }
        task.resume()
    }
    
    // Extract data to basic object.
    func extractData(data:NSString, sender:AnyObject?) {
        var parseError: NSError?
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        let myJson: AnyObject?
        do {
            myJson = try NSJSONSerialization.JSONObjectWithData(jsonData,
                options: [])
            print(myJson)
        }
            
        catch let error as NSError {
            parseError = error
            myJson = nil
        }
        var isError = true;
        if(parseError == nil) {
            isError = false;
        }
        
        /* CALL CALLBACK IN ORIGINAL VIEWCONTROLLER */
        if(sender is MyTableViewController) {
            let vc = sender as! MyTableViewController
            vc.extractJSON(isError, json:myJson!)
        }
        if(sender is MyProductViewController) {
            let vc = sender as! MyProductViewController
            vc.extractJSON(isError, json:myJson!)
        }
        if(sender is MyStoresViewController) {
            let vc = sender as! MyStoresViewController
            vc.extractJSON(isError, json:myJson!)
        }
    }
}
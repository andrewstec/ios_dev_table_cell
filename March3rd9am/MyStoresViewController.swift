//
//  MyStoresViewController.swift
//  March3rd9am
//
//  Created by Andrew Stec on 2016-03-03.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import UIKit



class MyStoresViewController: UITableViewController{
 
    
    var jsonUrl  = "http://apple.ssdhtp.com/api/Stores"
    var productArray:Array< productStruct > = Array < productStruct >()
    
    enum ErrorHandler:ErrorType {
        case ErrorFetchingResults
    }
    
    @IBOutlet var myStoresTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myStoresTableView.dataSource = self
        myStoresTableView.delegate   = self
        
        
        /* CALL REPOSITORY CLASS WITH SELF REFERENCE */
        let jsonRepo = JsonRepo();
        jsonRepo.getJSONData(jsonUrl, sender:self)
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("storesCell",
                forIndexPath: indexPath) as! MyStoresTableCell
            let productStruct = productArray[indexPath.row]
            //  cell.textLabel?.text = data.name
            cell.region.text! = productStruct.branch! + " " + productStruct.region!

            print("whatever")
            return cell
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return productArray.count
    }
    
    /* THIS CALLBACK IS ENTERED AFTER THE JSON READ - it is called from the repo */
    func extractJSON(isError:Bool,json:AnyObject) {
        if (!isError) {
            if let list = json as? NSArray {
                for (var i = 0; i < list.count ; i++ ) {
                    if let data_block = list[i] as? NSDictionary {
                        // Automatically create object from JSON & add to array
                        productArray.append(productStruct(add: data_block))
                    }
                }
                
                // Refresh table once data is loaded.
                refreshTable()
            }
        }
    }
    
    // Refresh table once data is loaded.
    func refreshTable() {
        dispatch_async(dispatch_get_main_queue(), {
            self.myStoresTableView.reloadData()
            return
        })
    }
}

//
//  MyTableViewController.swift
//  March3rd9am
//
//  Created by Andrew Stec on 2016-02-29.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var jsonUrl  = "http://apple.ssdhtp.com/api/Products"
    var productArray:Array< productStruct > = Array < productStruct >()
    
    enum ErrorHandler:ErrorType {
        case ErrorFetchingResults
    }
    
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate   = self
        
        
        /* CALL REPOSITORY CLASS WITH SELF REFERENCE */
        let jsonRepo = JsonRepo();
        jsonRepo.getJSONData(jsonUrl, sender:self)
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("myCell",
        forIndexPath: indexPath) as! MyCellClass
            let productStruct = productArray[indexPath.row]
          //  cell.textLabel?.text = data.name
            cell.manufacturer!.text = productStruct.manufacturer!
            cell.productItem!.text    = productStruct.name!
            cell.price!.text = String(productStruct.price!)
     //       cell.manufacturer!.textAlignment = NSTextAlignment.Right
     //       cell.price.textAlignment = NSTextAlignment.Right
    //        cell.productItem.textAlignment = NSTextAlignment.Left
            let image: UIImage = UIImage(named: cell.productItem.text!)!
            cell.imageView!.image = image
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
            self.myTableView.reloadData()
            return
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "productViewSegue") {
            let vc = segue.destinationViewController
            as! MyProductViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let rowNum = indexPath!.row
            vc.destinationMessage = String(indexPath!.row)
            print(productArray[indexPath!.row].productID)
            print(productArray[indexPath!.row].manufacturer)
            print(productArray[indexPath!.row].manufacturer)
            vc.productID = String(productArray[indexPath!.row].productID)
            vc.price = String(productArray[indexPath!.row].price)
            vc.manufacturer = productArray[indexPath!.row].manufacturer
            print(rowNum)
            print("test");
        }
    }
}



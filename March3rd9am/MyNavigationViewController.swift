//
//  NavigationController.swift
//  March3rd9am
//
//  Created by Andrew Stec on 2016-02-29.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import UIKit

class MyNavigationViewController: UITableViewController {

    class MyTableViewController: UITableViewController {
        
        var arrayOfProducts: [String] = ["Heinz", "Gerkin", "Pilsbury"]
        var arrayOfPrices: [Double] = [2.00, 3.44, 2.32]
        @IBOutlet var myTableView: UITableView!
        var arrayOfManufacturers: [String] = ["One", "Two", "Three"]
        
        var arrayOfInts: [Int] = [1, 2, 3]
        var arrayOfStrings: [String] = ["One", "Two", "Three"]
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        override func tableView(tableView: UITableView,
            cellForRowAtIndexPath indexPath: NSIndexPath)
            -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("myCell",
            forIndexPath: indexPath) as! MyCellClass
            cell.manufacturer.text = arrayOfStrings[indexPath.row]
            cell.productItem.text    = String(arrayOfInts[indexPath.row])
            cell.prices.text = String(arrayOfPrices[indexPath.row])
            return cell
        }
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
            return self.arrayOfStrings.count
        }
        
    }


}

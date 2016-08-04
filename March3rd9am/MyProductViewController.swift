//
//  MyProductViewController.swift
//  March3rd9am
//
//  Created by Andrew Stec on 2016-03-02.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import UIKit

class MyProductViewController: UIViewController {

    @IBOutlet weak var productField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var manufacturerField: UITextField!
    @IBOutlet weak var discountField: UITextField!
    
    
    var destinationMessage: String = ""
    var jsonUrl  = "http://apple.ssdhtp.com/api/Manufacturers/"
    var jsonArray:Array< productStruct > = Array < productStruct >()
    var product:productStruct!
    var productManufacturer:String?
    var productID: String! = ""
    var price: String! = ""
    var manufacturer: String! = ""
    
    enum ErrorHandler:ErrorType {
        case ErrorFetchingResults
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //CALL REPOSITORY CLASS WITH SELF REFERENCE
        let jsonRepo = JsonRepo()
        print(manufacturer!)
        if (manufacturer != nil ) {

            print(jsonUrl + manufacturer!)
            let fullURL: String? = (jsonUrl + manufacturer!);
            let formattedFullURL: String = fullURL!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
          //  jsonRepo.getJSONData(jsonUrl + manufacturer!, sender:self)
            jsonRepo.getJSONData(formattedFullURL, sender:self)
        }
        else {
            jsonRepo.getJSONData(jsonUrl , sender:self)

        }
        
        
        
        productField.text! = productID!
        
      //  let formatter = NSNumberFormatter()
      //  formatter.NumberStyle = .CurrencyStyle
        
        priceField.text! = price!
        manufacturerField.text! = manufacturer
    
        
    }
    
    func tableView() -> Int {
        return jsonArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func extractJSON(isError:Bool, json:AnyObject) {
        if (!isError) {

                    if let data_block = json as? NSDictionary {
                        jsonArray.append(productStruct(add: data_block))
                        discountField.text! = String(jsonArray[0].mfgDiscount!)
                        
                        
            }
        }
    }
    

    

}

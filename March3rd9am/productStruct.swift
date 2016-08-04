import UIKit

struct productStruct {
    var name:String?
    var productID:Int?
    var mfgDiscount:Float?
    var manufacturer:String?
    var price:Double?
    var branch:String?
    var region:String?
    init(add:       NSDictionary) {
        // Reference JSON properties.
        // You could add more here.
        name = add["name"] as? String
        productID = add["productID"] as? Int
        manufacturer = add["mfg"] as? String
        price = add["price"] as? Double
        mfgDiscount = add["mfgDiscount"] as? Float
        branch = add["branch"] as? String
        region = add["region"] as? String
    }
    
    init() {
        //default constructor
    }
    
    
}
//
//  TopTableViewCell.swift
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

extension Dictionary {
    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
        var array = Array(self.keys)
        sort(&array, isOrderedBefore)
        return array
    }
    
    // Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    
    // Faster because of no lookups, may take more memory because of duplicating contents
    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        var array = Array(self)
        sort(&array) {
            let (lk, lv) = $0
            let (rk, rv) = $1
            return isOrderedBefore(lv, rv)
        }
        return array.map {
            let (k, v) = $0
            return k
        }
    }
}

class TopTableViewCell: UITableViewCell
{
    
    
    var row: Int? {
        didSet {
            updateUI()
        }
    }
    
    var indexKeyNeg: String? {
        didSet {
            
        }
    }
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var anonPost: UILabel!
    
    @IBAction func upvote(sender: AnyObject) {
        println("upvote")
        var query = PFQuery(className: "post")
        var array = query.findObjects()
        var index = array.count - 1 - row!
        if index >= 0 {
            println(index)
            var newNumber = array[index].objectForKey("upvotes") as Int?
            if newNumber != nil {
                println(newNumber)
                newNumber!++
                println(newNumber)
                array[index].setObject(newNumber, forKey: "upvotes")
                println(array[index].objectForKey("upvotes"))
                countLabel.text = String(newNumber!)
                array[index].saveInBackgroundWithBlock {
                    (success: Bool!, error: NSError!) -> Void in
                    if success! {
                        NSLog("Object created with id: \(array[index].objectId)")
                    } else {
                        NSLog("%@", error)
                    }
                }
            }
        }
        /*var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        let number = NSUserDefaults.standardUserDefaults().objectForKey(indexKeyNeg!) as Int?
        if number != nil {
            var numberN = number!
            numberN++
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: indexKeyNeg!)
        }*/
    }
    
    @IBAction func downvote(sender: AnyObject) {
        println("downvote")
        var query = PFQuery(className: "post")
        var array = query.findObjects()
        var index = array.count - 1 - row!
        if index >= 0 {
            println(index)
            var newNumber = array[index].objectForKey("upvotes") as Int?
            if newNumber != nil {
                println(newNumber)
                newNumber!--
                println(newNumber)
                array[index].setObject(newNumber, forKey: "upvotes")
                println(array[index].objectForKey("upvotes"))
                countLabel.text = String(newNumber!)
                array[index].saveInBackgroundWithBlock {
                    (success: Bool!, error: NSError!) -> Void in
                    if success! {
                        NSLog("Object created with id: \(array[index].objectId)")
                    } else {
                        NSLog("%@", error)
                    }
                }
            }
        }
        /*var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        let number = NSUserDefaults.standardUserDefaults().objectForKey(indexKeyNeg!) as Int?
        if number != nil {
            var numberN = number!
            numberN--
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: indexKeyNeg!)
        }*/
    }
    
    
    
    func updateUI() {
        anonPost?.attributedText = nil
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        var keys = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys
        
        let dictType = NSUserDefaults.standardUserDefaults().dictionaryRepresentation() as Dictionary
        var dict = Dictionary<String, Int>()
        for var i = -(count/2); i < 0; i++ {
            var newString = String(i)
            var newNumber = defaults.objectForKey(String(i))as Int?
            if newNumber != nil {
                dict.updateValue(newNumber!, forKey: newString)
            }
        }
        
        println(dict)
        
        var myArr = Array(dict.keys)
        var sortedKeys: () = sort(&myArr) {
            var obj1 = dict[$0] // get ob associated w/ key 1
            var obj2 = dict[$1] // get ob associated w/ key 2
            return obj1 > obj2
        }
        
        println(myArr) // sorted
        
        var indexCur = myArr[row!]
        var indexCurNum: Int? = myArr[row!].toInt()
        indexKeyNeg = String(indexCurNum!)
        let newText = defaults.objectForKey(String(-indexCurNum!)) as String?
        let newNumber = defaults.objectForKey(indexCur)as Int?
        if newText != nil && newNumber != nil {
            anonPost.text = newText!
            countLabel.text = String(newNumber!)
        }
    }
}

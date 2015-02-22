//
//  TweetTableViewCell.swift
//  Smashtag
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
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        let number = NSUserDefaults.standardUserDefaults().objectForKey(indexKeyNeg!) as Int?
        if number != nil {
            var numberN = number!
            numberN++
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: indexKeyNeg!)
        }
       // updateUI()
        /*var count: Int = NSUserDefaults.standardUserDefaults().integerForKey(anonPost.text!)
        count++
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(count, forKey: anonPost.text!)
        countLabel.text = String(count)*/
    }
    
    @IBAction func downvote(sender: AnyObject) {
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        let number = NSUserDefaults.standardUserDefaults().objectForKey(indexKeyNeg!) as Int?
        if number != nil {
            var numberN = number!
            numberN--
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: indexKeyNeg!)
        }
       // updateUI()
    }
    
    
    
    func updateUI() {
        anonPost?.attributedText = nil
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        //index = index
        let defaults = NSUserDefaults.standardUserDefaults()
        var keys = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys
        
        let dictType = NSUserDefaults.standardUserDefaults().dictionaryRepresentation() as Dictionary
       // dictType.keysSortedByValue(>)
        var dict = Dictionary<String, Int>()
        //var dict :  Dictionary<String, Int>?
        for var i = -(count/2); i < 0; i++ {
            var newString = String(i)
            var newNumber = defaults.objectForKey(String(i))as Int?
            if newNumber != nil {
                dict.updateValue(newNumber!, forKey: newString)
            }
        }
        
        println(dict)
        
       /* println(dict)
        dict.keysSortedByValue(>)
        println(dict)
        dict.sortedKeysByValue(>)
        println(dict)*/
        
     //   var dict = ["cola" : 10, "fanta" : 12, "sprite" : 8]
        
        var myArr = Array(dict.keys)
        var sortedKeys: () = sort(&myArr) {
            var obj1 = dict[$0] // get ob associated w/ key 1
            var obj2 = dict[$1] // get ob associated w/ key 2
            return obj1 > obj2
        }
        
        println(myArr) // ["fanta", "cola", "sprite"]
        
        var indexCur = myArr[row!]
        var indexCurNum: Int? = myArr[row!].toInt()
        indexKeyNeg = String(indexCurNum!)
        let newText = defaults.objectForKey(String(-indexCurNum!)) as String?
        let newNumber = defaults.objectForKey(indexCur)as Int?
        if newText != nil && newNumber != nil {
            anonPost.text = newText!
            countLabel.text = String(newNumber!)
        }
        
        // println(keys)
        //keys.
        //var revK = keys.reverse()
        
        /*var arr = []
        
        for var i = -(count/2); i < 0; i++ {
            arr.
        }*/
        
        
        /*var arrK = keys.array
        
        let newText = defaults.objectForKey(String(index)) as String?
        let newNumber = defaults.objectForKey(String(-index))as Int?
        if newText != nil && newNumber != nil {
            anonPost.text = newText!
            countLabel.text = String(newNumber!)
        }*/
        
        
        /*if newNumber != nil && newText != nil {
        anonPost.text = newText
        countLabel.text = String(newNumber)
        }*/
        //var i = 0
        // keys.last
        /*var k = arrK[index]
        println("anon post label >>")
        //println(k.description)
        let x = k as String
        anonPost.text = x//.description
        let val = defaults.integerForKey(x)
        countLabel.text = String(val)*/
        
        /*for k in arrK {
        if(i == count - 1 - row) {
        let x = k as String
        println("anon post label >>")
        println(k.description)
        println(x)
        let val = defaults.integerForKey(x)
        anonPost.text = k.description
        countLabel.text = String(val)
        break
        }
        i++
        }*/
        /*if let name = defaults.objectForKey(String(index)) {
        println(name)
        anonPost?.text = name as NSString
        }*/
    }
}

//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

extension Dictionary {
    func sortedKeys(isOrderedBefore:(KeyType,KeyType) -> Bool) -> [KeyType] {
        var array = Array(self.keys)
        sort(&array, isOrderedBefore)
        return array
    }
    
    // Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
    func sortedKeysByValue(isOrderedBefore:(ValueType, ValueType) -> Bool) -> [KeyType] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    
    // Faster because of no lookups, may take more memory because of duplicating contents
    func keysSortedByValue(isOrderedBefore:(ValueType, ValueType) -> Bool) -> [KeyType] {
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
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var anonPost: UILabel!
    
    @IBAction func upvote(sender: AnyObject) {
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        let number = NSUserDefaults.standardUserDefaults().objectForKey(String(-index)) as Int?
        if number != nil {
            var numberN = number!
            numberN++
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: String(-index))
        }
        
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
        let number = NSUserDefaults.standardUserDefaults().objectForKey(String(-index)) as Int?
        if number != nil {
            var numberN = number!
            numberN--
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: String(-index))
        }
        
    }
    
    
    
    func updateUI() {
        anonPost?.attributedText = nil
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        //index = index
        let defaults = NSUserDefaults.standardUserDefaults()
        var keys = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys
        // println(keys)
        //keys.
        //var revK = keys.reverse()
        
        /*var arr = []
        
        for var i = -(count/2); i < 0; i++ {
            arr.
        }*/
        
        
        var arrK = keys.array
        
        let newText = defaults.objectForKey(String(index)) as String?
        let newNumber = defaults.objectForKey(String(-index))as Int?
        if newText != nil && newNumber != nil {
            anonPost.text = newText!
            countLabel.text = String(newNumber!)
        }
        
        
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

//
//  TopPostTableViewCell.swift
//
//  Created by Lawrence Lin Murata on 2/18/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TopPostTableViewCell: UITableViewCell
{
    
    //type of mention cell
    var type: String? {
        didSet {
        }
    }
    
    //keeps track of the current row
    var row: Int? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var content: UILabel!
    
    func updateUI() {
        println("UPDATEUI")
        content?.attributedText = nil
        if let type = self.type
        {
            //        if let tweet = self.tweet {
            switch type {
                //prepares URL cell
            case "Text":
                content?.attributedText = nil
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
                let newText = defaults.objectForKey(String(-indexCurNum!)) as String?
                if newText != nil {
                    content.text = newText!
                }
                
                //user mention cell
            case "Upvotes":
                content?.attributedText = nil
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
                let newNumber = defaults.objectForKey(indexCur)as Int?
                if newNumber != nil {
                    content.text = String(newNumber!)
                }
                
                //hashtag cell
            default:
                println("hi")
                //content?.text = tweet.text
            }
            
        }
        //    }
    }
}

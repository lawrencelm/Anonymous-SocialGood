//
//  AnonTableViewCell.swift
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class AnonTableViewCell: UITableViewCell
{
    
    var row: Int? {
        didSet {
            updateUI()
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
        let number = NSUserDefaults.standardUserDefaults().objectForKey(String(-index)) as Int?
        if number != nil {
            var numberN = number!
            numberN++
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: String(-index))
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
        let number = NSUserDefaults.standardUserDefaults().objectForKey(String(-index)) as Int?
        if number != nil {
            var numberN = number!
            numberN--
            println(numberN)
            countLabel.text = String(numberN)
            defaults.setInteger(numberN, forKey: String(-index))
        }*/
        
    }
    
    func updateUI() {
        anonPost?.attributedText = nil
        var query = PFQuery(className: "post")
        var array = query.findObjects()
        var index = array.count - 1 - row!
        if index >= 0 {
            let newText: AnyObject? = array[index].objectForKey("post")
            let newNumber: AnyObject? = array[array.count - 1 - row!].objectForKey("upvotes")
            if newText != nil && newNumber != nil {
                anonPost.text = newText as? String
                countLabel.text = String(newNumber as Int)
            }
        }
        /*var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count/2 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        var keys = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys

        
        var arrK = keys.array
        
        let newText = defaults.objectForKey(String(index)) as String?
        let newNumber = defaults.objectForKey(String(-index))as Int?
        if newText != nil && newNumber != nil {
            anonPost.text = newText!
            countLabel.text = String(newNumber!)
        }*/
    }
}

//
//  TweetTableViewCell.swift
//  Smashtag
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
    
    /*var anonText: String? {
        didSet {
            
        }
    }*/
    
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

        
        var arrK = keys.array
        
        let newText = defaults.objectForKey(String(index)) as String?
        let newNumber = defaults.objectForKey(String(-index))as Int?
        if newText != nil && newNumber != nil {
            anonPost.text = newText!
            countLabel.text = String(newNumber!)
        }
    }
}

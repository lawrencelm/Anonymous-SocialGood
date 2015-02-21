//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by CS193p Instructor.
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
    
    var anonText: String? {
        didSet {
            
        }
    }
    
    @IBOutlet weak var anonPost: UILabel!
    
    @IBAction func upvote(sender: AnyObject) {
        var count: Int = NSUserDefaults.standardUserDefaults().integerForKey(anonText!)
        count++
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(count, forKey: anonText!)
    }
    
    @IBAction func downvote(sender: AnyObject) {
        var count: Int = NSUserDefaults.standardUserDefaults().integerForKey(anonText!)
        count--
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(count, forKey: anonText!)
    }
    
    func updateUI() {
        anonPost?.attributedText = nil
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count - 1 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.objectForKey(String(index)) {
            println(name)
            anonPost?.text = name as NSString
        }
    }
}

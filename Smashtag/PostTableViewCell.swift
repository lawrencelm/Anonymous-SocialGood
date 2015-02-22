//
//  PostTableViewCell.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata on 2/18/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell
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
                        println("entering URLs")
                        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
                        var index = count/2 - row!

                        let defaults = NSUserDefaults.standardUserDefaults()
                        var keys = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys
                        
                        let newText = defaults.objectForKey(String(index)) as String?
                        println(newText)
                        if newText != nil {
                            content.text = newText!
                        }

                    //user mention cell
                case "Upvotes":
                    var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
                    var index = count/2 - row!
                    //index = index
                    let defaults = NSUserDefaults.standardUserDefaults()
                    var keys = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys
                    
                    let newNumber = defaults.objectForKey(String(-index))as Int?
                    if newNumber != nil{
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

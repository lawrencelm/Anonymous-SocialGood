//
//  MentionTableViewCell.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata on 2/18/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class MentionTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    //type of mention cell
    var type: String? {
        didSet {
        }
    }
    
    //keeps track of the current row
    var row: Int? {
        didSet {
        }
    }
    
    @IBOutlet weak var content: UILabel!
    
    func updateUI() {
        content?.attributedText = nil
        if let type = self.type
        {
            if let tweet = self.tweet {
                switch type {
                //prepares URL cell
                case "URL":
                    var string: String = ""
                    var count = 0
                    for i in tweet.urls {
                        if count == row {
                            for char in i.description {
                                if char != " " {
                                    string.append(char)
                                } else {
                                    break
                                }
                            }
                        }
                        count++
                    }
                    if string != "" {
                        println("entering URLs")
                        content?.text = string
                    }
                //user mention cell
                case "User Mentions":
                    var string: String = ""
                    var count = 0
                    for i in tweet.userMentions {
                        if count == row {
                            for char in i.description {
                                if char != " " {
                                    string.append(char)
                                } else {
                                    break
                                }
                            }
                        }
                        count++
                    }
                    if string != "" {
                        content?.text = string
                    }
                //hashtag cell
                case "Hashtags":
                    var string: String = ""
                    var count = 0
                    for i in tweet.hashtags {
                        if count == row {
                            for char in i.description {
                                if char != " " {
                                    string.append(char)
                                } else {
                                    break
                                }
                            }
                        }
                        count++
                    }
                    if string != "" {
                        content?.text = string
                    }
                //user cell
                case "User":
                    content?.text = tweet.user.name
                default:
                    content?.text = tweet.text
                }

            }
        }
    }
}

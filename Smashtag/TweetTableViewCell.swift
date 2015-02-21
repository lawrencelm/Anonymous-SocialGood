//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
        
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            
            var main_string = tweet.text
            var hashtag = tweet.hashtags
            var urls = tweet.urls
            var users = tweet.userMentions
            var attributedString = NSMutableAttributedString(string:main_string)
            
            //sets color for hashtags
            for index in hashtag {
                var hash = index.description
                var tempHash = ""
                for character in hash {
                    if character != " " {
                        tempHash.append(character)
                    } else{
                        break
                    }
                }
                var string_to_color = tempHash
                var range = (main_string as NSString).rangeOfString(string_to_color)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
            }
            
            //sets color for urls
            for index in urls {
                var url = index.description
                var tempUrl = ""
                for character in url {
                    if character != " " {
                        tempUrl.append(character)
                    }else{
                        break
                    }
                }
                var string_to_color = tempUrl
                var range = (main_string as NSString).rangeOfString(string_to_color)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.purpleColor(), range: range)
            }
            
            //sets color for user mentions
            for index in users{
                var user = index.description
                var tempUser = ""
                for character in user {
                    if character != " " {
                        tempUser.append(character)
                    }else{
                        break
                    }
                }
                var string_to_color = tempUser
                var range = (main_string as NSString).rangeOfString(string_to_color)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: range)
            }

            
            tweetTextLabel?.attributedText = attributedString
            
            if tweetTextLabel?.attributedText != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }

    }
}

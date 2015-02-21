//
//  MentionTableViewCell.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata on 2/18/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var row: Int? {
        didSet {
            
        }
    }
    
    func updateUI() {
        //preparing image cell
        if let tweet = self.tweet {
            var string: String = ""
            var count = 0
            for i in tweet.media {
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
            if let profileImageURL = NSURL(string: string) {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    myImageView?.image = UIImage(data: imageData)
                }
            }

        }
    }

}

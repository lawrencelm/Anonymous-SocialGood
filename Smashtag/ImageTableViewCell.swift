//
//  ImageTableViewCell.swift
//
//  Created by Lawrence Lin Murata on 2/18/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var row: Int? {
        didSet {
            updateUI()
        }
    }
    
    var url: String?
    
    func updateUI() {

            if let profileImageURL = NSURL(string: url!) {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    myImageView?.image = UIImage(data: imageData)
                }
            }
    }

}

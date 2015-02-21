//
//  MentionTableViewCell.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata on 2/18/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell
{

    var row: Int? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var searchLabel: UILabel!
    
    func updateUI() {
        //creating each search cell with the top 100 most recent search terms
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        var index = count - 1 - row!
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.objectForKey(String(index)) {
            println(name)
            searchLabel?.text = name as NSString
        }
     }
}

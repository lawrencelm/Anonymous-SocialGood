//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TopTableViewController: UITableViewController, UITextFieldDelegate
{
    
    private struct Storyboard {
        static let CellReuseIdentifier = "top"
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        //return tweets.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        //return tweets[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as TopTableViewCell
        
        cell.row = indexPath.row
        
        return cell
    }
}

//
//  TopTableViewController.swift
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TopTableViewController: UITableViewController, UITextFieldDelegate
{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let mtvc = destination as? PostTableViewController {
            var row: Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.row)!
            mtvc.isOrdered = true
            mtvc.row = row
        }
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "top"
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as TopTableViewCell
        
        cell.row = indexPath.row
        
        return cell
    }
}

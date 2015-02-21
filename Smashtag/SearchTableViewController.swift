//
//  MentionTableViewController.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata on 2/17/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UITextFieldDelegate
{
    var tweet: Tweet?
    
    private struct Storyboard {
        static let CellReuseIdentifier = "search"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let ttvc = destination as? TweetTableViewController {
            //prepares segue to search for the search term selected
            var row: Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.row)!
            var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
            var index = count - 1 - row
            let defaults = NSUserDefaults.standardUserDefaults()
            if let name = defaults.objectForKey(String(index)) {
                println(name)
                ttvc.searchText = name as NSString
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //only 100 most recent search terms are displayed
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //sets cell and its row
        let cell = tableView.dequeueReusableCellWithIdentifier("search", forIndexPath: indexPath) as SearchTableViewCell
        cell.row = indexPath.row
        return cell
    }
    
    
}

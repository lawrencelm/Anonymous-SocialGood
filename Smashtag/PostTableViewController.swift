//
//  PostTableViewController.swift
//
//  Created by Lawrence Lin Murata on 2/17/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController, UITextFieldDelegate
{
    
    //prepares for segue to image view or to search view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
     if let itvc = destination as? ImageViewController {
         //Image moves ot a special image view
         itvc.imageURL = NSURL(string: "http://u.s.kqed.net/2014/01/16/PaloAltoRoadSign.jpg")
        }
    }
    
    var row: Int?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //URL, hashtag, user mention, user who posted, image
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //the number of rows is the number of elements each category has
        return 1
    }
    
    //Sets header title of each section, is it exists
    override func tableView(UITableView, titleForHeaderInSection section: Int) -> String?{
        switch section {
        case 0:
            return "Text"
        case 1:
            return "Upvotes"
        case 2:
            return "Image"
        default:
            return nil
        }
    }
    
    //Sets cell and sends information that is used in the cell class
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch indexPath.section {
            //sections 0, 1, 2, 4 create mention cells
            //section 3 creates an image cell
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as PostTableViewCell
            cell.type = "Text"
            cell.row = row
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as PostTableViewCell
            cell.type = "Upvotes"
            cell.row = row
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("image", forIndexPath: indexPath) as ImageTableViewCell
            cell.url = "http://u.s.kqed.net/2014/01/16/PaloAltoRoadSign.jpg"
            cell.row = row
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as PostTableViewCell
            cell.type = nil
            cell.row = row
            return cell
        }
    }
}

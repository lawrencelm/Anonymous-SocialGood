//
//  MentionTableViewController.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata on 2/17/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class MentionTableViewController: UITableViewController, UITextFieldDelegate
{
    var tweet: Tweet?

    //prepares for segue to image view or to search view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let ttvc = destination as? TweetTableViewController {
            var row: Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.row)!
            var section :Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.section)!
            switch section {
            case 0: //URL is opened in Safari
                var string: String = ""
                var count = 0
                for i in tweet!.urls {
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
                ttvc.searchText = string
                UIApplication.sharedApplication().openURL(NSURL(string: string)!)
            case 1: //Hashtag is searched in search table view
                var string: String = ""
                var count = 0
                for i in tweet!.hashtags {
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
                ttvc.searchText = string
            case 2: //User mention is searched in search table view
                var string: String = ""
                var count = 0
                for i in tweet!.userMentions {
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
                ttvc.searchText = string
            case 4:
                //extra credit: items 1 and 2. searches not only for
                //the poster's name but also for tweets from the poster
                //by using the OR operator and the quotation marks from the
                //Twitter search query syntax
                ttvc.searchText = "\"" + tweet!.user.name + "\" OR @" + tweet!.user.screenName
            default:
                ttvc.searchText = "#stanford"
            }
        } else if let itvc = destination as? ImageViewController {
            //Image moves ot a special image view
            var row: Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.row)!
            var string: String = ""
            var count = 0
            for i in tweet!.media {
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
            itvc.imageURL = NSURL(string: string)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //URL, hashtag, user mention, user who posted, image
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //the number of rows is the number of elements each category has
        switch section {
        case 0:
            return tweet!.urls.count
        case 1:
            return tweet!.hashtags.count
        case 2:
            return tweet!.userMentions.count
        case 3:
            return tweet!.media.count
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    //Sets header title of each section, is it exists
    override func tableView(UITableView, titleForHeaderInSection section: Int) -> String?{
        switch section {
        case 0:
            if(tweet!.urls.count == 0) {
                return nil
            }
            return "URL"
        case 1:
            if(tweet!.hashtags.count == 0) {
                return nil
            }
            return "Hashtags"
        case 2:
            if(tweet!.userMentions.count == 0) {
                return nil
            }
            return "User Mentions"
        case 3:
            if(tweet!.media.count == 0) {
                return nil
            }
            return "Images"
        case 4:
            return "User"
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
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as MentionTableViewCell
            cell.type = "URL"
            cell.row = indexPath.row
            cell.tweet = tweet
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as MentionTableViewCell
            cell.type = "Hashtags"
            cell.row = indexPath.row
            cell.tweet = tweet
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as MentionTableViewCell
            cell.type = "User Mentions"
            cell.row = indexPath.row
            cell.tweet = tweet
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("image", forIndexPath: indexPath) as ImageTableViewCell
            cell.row = indexPath.row
            cell.tweet = tweet
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as MentionTableViewCell
            cell.type = "User"
            cell.row = indexPath.row
            cell.tweet = tweet
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("content", forIndexPath: indexPath) as MentionTableViewCell
            cell.type = nil
            cell.row = indexPath.row
            cell.tweet = tweet
            return cell
        }
    }
}

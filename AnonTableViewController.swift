//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class AnonTableViewController: UITableViewController, UITextFieldDelegate
{
    
    //might use this later for Post view
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let mtvc = destination as? MentionTableViewController {
            var row: Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.row)!
            var section :Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.section)!
        }
    }*/
    
    
    // MARK: - Public API
    
    var postText: String? {
        didSet {
            //lastSuccessfulRequest = nil
            searchTextField?.text = postText
            //tweets.removeAll()
            tableView.reloadData() // clear out the table view
            refresh()
        }
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.estimatedRowHeight = tableView.rowHeight
        //tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Refreshing
    
   /* private var lastSuccessfulRequest: TwitterRequest?
    
    private var nextRequestToAttempt: TwitterRequest? {
        if lastSuccessfulRequest == nil {
            if postText != nil {
                return TwitterRequest(search: postText!, count: 100)
            } else {
                return nil
            }
        } else {
            return lastSuccessfulRequest!.requestForNewer
        }
    }
    
    @IBAction private func refresh(sender: UIRefreshControl?) {
        if let request = nextRequestToAttempt {
            request.fetchTweets { (newTweets) -> Void in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    if newTweets.count > 0 {
                        self.lastSuccessfulRequest = request // oops, forgot this line in lecture
                        //self.tweets.insert(newTweets, atIndex: 0)
                        self.tableView.reloadData()
                    }
                    sender?.endRefreshing()
                }
            }
        } else {
            sender?.endRefreshing()
        }
    }*/
    
    
    
    // store the searchText into a dictionary in NSUserDefaults
    func refresh() {
        if postText != nil{
        println("post text >>")
        println(postText)
        let defaults = NSUserDefaults.standardUserDefaults()
        var votes = 0
        /*struct myDataType{
        }*/
            
        //var array = [, votes]
        /*if defaults.objectForKey("0") == nil {
            defaults.setObject(0, forKey: "0")//postText!)
        }*//* else {
            let number = NSUserDefaults.standardUserDefaults().objectForKey("0")) as Int?
            if number != nil {
                var numberN = number!
                numberN++
                println(numberN)
                countLabel.text = String(numberN)
                defaults.setInteger(numberN, forKey: String(index))
            }
        }*/
        /*defaults.setInteger(votes,forKey: postText!);*/
            
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
        println(count) //MAKE SURE IT'S AN EVEN NUMBER
            
        /*if count % 2 != 0 {
            for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
                println("cleaning")
                NSUserDefaults.standardUserDefaults().removeObjectForKey(key.description)
            }
            count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count
            println(count)
        }*/
            
        /*let dictType1 = NSUserDefaults.standardUserDefaults().dictionaryRepresentation() as Dictionary
        println(dictType1)*/
        defaults.setObject(postText, forKey: String(count/2 + 1))
        defaults.setObject(votes, forKey: String(-(count/2 + 1)))
        /*let dictType = NSUserDefaults.standardUserDefaults().dictionaryRepresentation() as Dictionary
        println(dictType)*/
            
        //var x = defaults.integerForKey(postText!)
        //println(x)
        // println("stored \(postText)")
        //count++
        //println(defaults)
        
        // var keys = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys
        // var values = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().values
        // println("keys and vals:")
        // println(keys)
        // println(values)
        //refreshControl?.beginRefreshing()
        //refresh(refreshControl)
        }
    }
    
    // MARK: - Storyboard Connectivity
    
    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = postText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            postText = textField.text
        }
        return true
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "anon"
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
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as AnonTableViewCell
        
        cell.row = indexPath.row
        
        return cell
    }
}

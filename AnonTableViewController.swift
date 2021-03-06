//
//  AnonTableViewController.swift
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class AnonTableViewController: UITableViewController, UITextFieldDelegate
{
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let mtvc = destination as? PostTableViewController {
            var row: Int = (self.tableView.indexPathForCell(sender as UITableViewCell)?.row)!
            mtvc.row = row
        }
    }
    
    var needReload : Bool? {
        didSet {
            tableView.reloadData() // clear out the table view
            refresh()
        }
    }
    
    
    // MARK: - Public API
    
    var postText: String? {
        didSet {
            searchTextField?.text = postText
            tableView.reloadData() // clear out the table view
            refresh()
        }
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.parentViewController?.title = "Recent";
        var rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target:self, action: "composeButton")
        self.parentViewController?.navigationItem.rightBarButtonItem = rightBarButton;
        rightBarButton.action = "buttonAction:"
        rightBarButton.target = self
        refresh()
        
        //self.navigationController?.navigationBar.tintColor = UIColor.purpleColor()
        //self.navigationItem.backBarButtonItem?.tintColor = UIColor.purpleColor()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        
    }
    
    @IBAction func unwindToRecent(segue: UIStoryboardSegue) {
        
    }
    
    func buttonAction(sender: UIButton!){
        performSegueWithIdentifier("bogus", sender:self)
    }
    
    // MARK: - Refreshing
 
    // store the searchText into a dictionary in NSUserDefaults
    func refresh() {
        if postText != nil{
            println("post text >>")
            println(postText)
            
            var post = PFObject(className: "post")
            post.setObject(postText, forKey: "content")
            post.setObject(0, forKey: "upvotes")
            post.saveInBackgroundWithBlock {
                (success: Bool!, error: NSError!) -> Void in
                if success! {
                    NSLog("Object created with id: \(post.objectId)")
                } else {
                    NSLog("%@", error)
                }
            }
            
       /* let defaults = NSUserDefaults.standardUserDefaults()
        var votes = 0
            
        var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count

        defaults.setObject(postText, forKey: String(count/2 + 1))
        defaults.setObject(votes, forKey: String(-(count/2 + 1)))*/
            
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
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var query = PFQuery(className: "post")
        var array = query.findObjects()
        if array.count < 100 {
            return array.count
        } else {
            return 100
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as AnonTableViewCell
        
        cell.row = indexPath.row
        
        return cell
    }
}

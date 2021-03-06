//
//  WriteTableViewController.swift
//
//  Created by Lawrence Lin Murata.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController, UITextFieldDelegate
{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let mtvc = destination as? AnonTableViewController {
            mtvc.needReload = true
        }
        }
        
    
    // MARK: - Public API
    
    var postText: String? {
        didSet {
            searchTextField?.text = postText
            refresh()
        }
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parentViewController?.title = "Top posts";
        var rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target:self, action: "composeButton")
        self.parentViewController?.navigationItem.rightBarButtonItem = rightBarButton;
        rightBarButton.action = "buttonAction:"
        rightBarButton.target = self
        refresh()
        
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
            let defaults = NSUserDefaults.standardUserDefaults()
            var votes = 0

            var count = NSUserDefaults.standardUserDefaults().dictionaryRepresentation().count

            defaults.setObject(postText, forKey: String(count/2 + 1))
            defaults.setObject(votes, forKey: String(-(count/2 + 1)))
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

}

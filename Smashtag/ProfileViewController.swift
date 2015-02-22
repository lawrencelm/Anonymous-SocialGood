//
//  ProfileViewController.swift
//  Smashtag
//
//  Created by Jessica Jiang on 2/22/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UITextFieldDelegate
{
    override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.parentViewController?.title = "Profile";
    var rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target:self, action: "actionButton")
    self.parentViewController?.navigationItem.rightBarButtonItem = rightBarButton;
    rightBarButton.action = "buttonAction:"
    rightBarButton.target = self
    //refresh()
    
    //self.navigationController?.navigationBar.tintColor = UIColor.purpleColor()
    //self.navigationItem.backBarButtonItem?.tintColor = UIColor.purpleColor()
    
    self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
}



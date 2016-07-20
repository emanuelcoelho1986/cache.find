//
//  ViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 18/11/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var loginView:FBLoginView = FBLoginView()
        loginView.center = self.view.center
        self.view.addSubview(loginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


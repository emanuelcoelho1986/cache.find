//
//  ViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 18/11/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit
import QuartzCore

class LoginViewController: UIViewController, FBLoginViewDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var passwordTextField: RPFloatingPlaceholderTextField!
    @IBOutlet weak var usernameTextField: RPFloatingPlaceholderTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var loginView:FBLoginView = FBLoginView()
        loginView.center = self.view.center
        loginView.delegate = self
        self.view.addSubview(loginView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("Go for it")
    }

    @IBAction func didPressedLoginButton(sender: AnyObject) {
    }
    
    @IBAction func didPressedOutsideComponents(sender: AnyObject) {
        NSLog("End editing")
        self.view.endEditing(true)
    }
    
    // MARK: Facebook Protocol Functions
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        performSegueWithIdentifier("segueUserIsLogged", sender: self)
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        NSLog("O user saiu")
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        NSLog("Informacao do utilizador")
        NSLog(user.name)
    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        NSLog("ERROR Facebook: Alguma coisa de errada aconteceu: \(error.description)")
    }
    /* End of Facebook Protocol Functions */

}


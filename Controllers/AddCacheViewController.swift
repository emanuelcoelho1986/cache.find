//
//  AddCacheViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 30/11/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit
import CoreData

class AddCacheViewController: UITableViewController {
    
    @IBOutlet weak var cacheTitleTextField: RPFloatingPlaceholderTextField!
    @IBOutlet weak var cacheDescriptionTextView: RPFloatingPlaceholderTextView!
    @IBOutlet weak var cacheLatitudeTextView: RPFloatingPlaceholderTextField!
    @IBOutlet weak var cacheElevationTextView: RPFloatingPlaceholderTextField!
    @IBOutlet weak var cacheLongitudeTextView: RPFloatingPlaceholderTextField!
    @IBOutlet weak var cacheDifficultyTextView: RPFloatingPlaceholderTextField!

    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            NSLog("Manage Object Context loaded");
            return managedObjectContext
        }
        else {
            return nil
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.separatorColor = UIColor.clearColor();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressedCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didPressedDoneButton(sender: AnyObject) {
        // Create the new cache item
        //1
        if let managedContext = self.managedObjectContext {
            //2
            NSLog("Manage Object Context Arrived")
            if let cacheEntity =  NSEntityDescription.entityForName("Cache", inManagedObjectContext: managedContext){
                let cache = Cache(entity: cacheEntity, insertIntoManagedObjectContext:managedContext)
                
                NSLog("\(cache)");
                
                //3 Save data to attributes
                cache.name = self.cacheTitleTextField.text
                cache.descricao = self.cacheDescriptionTextView.text
                cache.latitude = self.cacheLatitudeTextView.text
                cache.longitude = self.cacheLongitudeTextView.text
                cache.terrain = NSDecimalNumber(string: self.cacheElevationTextView.text)
                
                //4
                var error: NSError?
                if !managedContext.save(&error) {
                    println("Could not save \(error), \(error?.userInfo)")
                }else{
                    dismissViewControllerAnimated(true, completion: { () -> Void in
                        
                    })
                }
                //5
                //cache.append(person) //array de caches mas neste caso tem que ser de outra forma. View will appear ou assi
            }else{
                NSLog("Could not load Cache Method")
                
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

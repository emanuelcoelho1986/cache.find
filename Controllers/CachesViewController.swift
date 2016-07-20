//
//  CachesViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 26/11/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit
import CoreData

class CachesViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    let urlForCaches:String = "http://cachefindws.herokuapp.com/caches"
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()

    var allCaches = [Cache]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate:AppDelegate = (UIApplication.sharedApplication()).delegate as AppDelegate
        let context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "didRecieveNotificationForManageObjectContextAs",
            name: NSManagedObjectContextDidSaveNotification,
            object: context
        )
        
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadAllCaches() -> Void{
        NSLog("A carregar as caches")
    
        let fetchRequest = NSFetchRequest(entityName: "Cache")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Cache] {
            NSLog("Nr de caches encontradas: \(fetchResults.count)")
            allCaches = fetchResults
        }
    }
    
    func refresh(sender:AnyObject)
    {
        let url = NSURL(string: urlForCaches)
        let request = NSURLRequest(URL: url!)
        let connection:Void = NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue() , completionHandler: { (requestMade, dataFromServer, error) -> Void in
            
            var before:NSDate = NSDate()
            if var parsedCachesFromServer:Array = JSON(data: dataFromServer, options: NSJSONReadingOptions.MutableContainers, error: nil).arrayValue {
                
                var elapsedTime = NSDate().timeIntervalSinceDate(before)
                
                if var cacheEntity = NSEntityDescription.entityForName("Cache", inManagedObjectContext: self.managedObjectContext!){
                    for var index=0; index < parsedCachesFromServer.count; index++ {
                        var cacheAtIndex = parsedCachesFromServer[index]
                        
                        var cache:Cache = NSManagedObject(entity: cacheEntity, insertIntoManagedObjectContext: nil) as Cache
                        cache.name = cacheAtIndex["name"].stringValue != nil ? cacheAtIndex["name"].stringValue! : ""
                        cache.descricao = cacheAtIndex["description"].stringValue != nil ? cacheAtIndex["description"].stringValue! : ""
                        cache.latitude = cacheAtIndex["location"]["lat"].stringValue != nil ? cacheAtIndex["location"]["lat"].stringValue! : ""
                        cache.longitude = cacheAtIndex["location"]["lon"].stringValue != nil ? cacheAtIndex["location"]["lon"].stringValue! : ""
                        cache.oxcode = cacheAtIndex["oxcode"].stringValue != nil ? cacheAtIndex["oxcode"].stringValue! : ""
                        
                        if cache.name != "" && cache.latitude != "" && cache.longitude != ""{
                            self.allCaches.append(cache)
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })

    }
    
    func didRecieveNotificationForManageObjectContextAs(){
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allCaches.count == 0 {
            // Display a message when the table is empty
            var messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
            messageLabel.text = "No data is currently available. Please pull down to refresh."
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.sizeToFit()
            
            self.tableView.backgroundView = messageLabel;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return allCaches.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cacheRowIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        var cacheAtIndex = allCaches[indexPath.row]
        NSLog("\(cacheAtIndex)")
        cell.textLabel?.text = cacheAtIndex.name
        
        return cell
    }    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the LogItem object the user is trying to delete
            let cacheItemAt = allCaches[indexPath.row]
            
            // Delete it from the managedObjectContext
            if (managedObjectContext?.deleteObject(cacheItemAt) != nil) {
                // Refresh the table view to indicate that it's deleted
                self.loadAllCaches()
                
                // Tell the table view to animate out that row
                [self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)]
                
                managedObjectContext?.save(nil)
            }
        }
    }
    
     // MARK: - Prepare For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let path = self.tableView.indexPathForSelectedRow()!
        let destrinationViewController:DetailCacheViewController = segue.destinationViewController as DetailCacheViewController
        var arrayAuxOfCaches = allCaches
        destrinationViewController.selectedCahe = arrayAuxOfCaches.removeAtIndex(path.row)
        NSLog("Cache at index path: \(destrinationViewController.selectedCahe)")
    }
}
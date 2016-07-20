//
//  SettingsTableViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 04/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit

class SettingsTableViewController: UIViewController, FBLoginViewDelegate, NSXMLParserDelegate {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var nameOfUserTextLabel: UILabel!
    
    @IBOutlet var facebookViewContainer: UIView!
    let facebookDelegate:FBLoginView = FBLoginView()
    
    var cache = [Cache]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        facebookDelegate.delegate = self;
        var fbLoginView:FBLoginView = FBLoginView()
        self.facebookViewContainer.addSubview(fbLoginView)
        fbLoginView.center = CGPointMake(facebookViewContainer.frame.size.width / 2, facebookViewContainer.frame.size.height / 2);
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        NSLog(user.name)
        NSLog(user.objectID)
        var userImagePath:String = "https://graph.facebook.com/\(user.objectID)/picture?type=large"
        self.nameOfUserTextLabel.text = user.name
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            var facebookImageUrl = NSURL(string: userImagePath)!
            var facebookImageData:NSData = NSData(contentsOfURL: facebookImageUrl)!
            
            let getImage =  UIImage(data: facebookImageData)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.userPhotoImageView?.image = getImage
                return
            }
        }
    }
    
    @IBAction func didPressedImportCachesFromDropboxButton(sender: AnyObject) {
        //(Int, Int) -> (Int)
        var results = NSArray()
        var cachesFromGpx = [Cache]();
        
        DBChooser.defaultChooser().openChooserForLinkType(DBChooserLinkTypeDirect, fromViewController: self, completion:{ (results) -> Void in
            
            KVNProgress.show()
            KVNProgress.showWithStatus("Importing file. This can take a while")
            
            if let resultsFromDropBox = results {
                
                if results.count > 0{
                    NSLog("\(results.count) from Dropbox")
                    
                    for object in results {
                        // the object in the array is type of DBChooserResult
                        var dbchooserFile = object as DBChooserResult
                        
                        let asyncQueuePriority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(asyncQueuePriority, 0), { () -> Void in
                            
                            var error = NSError()
                            
                            if var serverData = NSData(contentsOfURL: dbchooserFile.link){
                                var cacheOperationData = CacheOperationData()
                                cacheOperationData.loadUnknownXML(serverData)
                            }
                            
                            
                            /**
@NSManaged var city: String
@NSManaged var country: String
@NSManaged var county: String
@NSManaged var dataCriacao: NSDate
@NSManaged var descricao: String
@NSManaged var difficulty: NSNumber
@NSManaged var latitude: String
@NSManaged var longitude: String
@NSManaged var name: String
@NSManaged var oxcode: String
@NSManaged var state: String
@NSManaged var status: NSNumber
@NSManaged var terrain: NSDecimalNumber
@NSManaged var belongsToDesafios: NSSet
@NSManaged var belongsToJogo: Jogo
*/
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                KVNProgress.showSuccessWithStatus("All done! Imported: \(cachesFromGpx.count)")
                            })
                        })
                    }
                }else{
                    NSLog("0 results from Dropbox")
                }
            }else{
                NSLog("Dropbox results is nil")
                KVNProgress.showErrorWithStatus("Something went wrong.\nPlease try again")
            }
            
        })
        
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        
    }
    
    func dismissProgressHUD(){
        
    }
    
    // MARK: – NSXMLParserDelegate methods
}

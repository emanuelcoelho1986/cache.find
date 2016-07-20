//
//  MesagesTableViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 27/11/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit
import Foundation

enum MESSAGE_TYPE:Int{
    case ALL_MESSAGES = 0
    case ONLY_MESSAGES = 1
    case ONLY_CHALLENGES = 2
}

class MesagesTableViewController: UITableViewController, UITableViewDelegate {
    
    @IBOutlet var messagesView: UITableView!
    
    let ALL_MESSAGE_ENDPOINT = "http://cachefindws.herokuapp.com/messages"
    let MESSAGES_ONLY_ENDPOINT = "http://cachefindws.herokuapp.com/messages_of_user"
    let CHALLENGES_ONLY_ENDPOINT = "http://cachefindws.herokuapp.com/challenges_of_user"
    
    @IBAction func didPressedNewMessageButton(sender: AnyObject) {
        
    }
    
    @IBAction func didPressedPreviousPageButton(sender: AnyObject) {
    }
    
    @IBAction func didPressedNextPageButton(sender: AnyObject) {
        
    }
    
    class Message {
        var origin:NSString
        var destination:NSString
        var messageType:NSString
        var title:NSString
        var description:NSString
        var createdAt:NSString
        
        init(fromOrigin origin: NSString,fromDestination destination: NSString, fromMessageType messageType: NSString, fromTitle title: NSString, fromDescription description: NSString, fromCreatedAt createdAt: NSString){
            self.origin = origin
            self.destination = destination
            self.messageType = messageType
            self.title = title
            self.description = description
            self.createdAt = createdAt
        }
    }
    
    var messages = [Message]()
    
    @IBAction func didSelectedMessageType(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case MESSAGE_TYPE.ALL_MESSAGES.rawValue:
            println("Selected all messages")
            // Invoke method to retrieve all messages
            queryAllMessages()
            
        case MESSAGE_TYPE.ONLY_MESSAGES.rawValue:
            println("Selected Only Messages")
            //Invoke method to retrieve only messages
            
        case MESSAGE_TYPE.ONLY_CHALLENGES.rawValue:
            println("Selected Only Challenges")
            //Invoke method to retrieve only challenges
            
        default:
            println("Invalid selection")
        }
    }
    
    func queryAllMessages() -> Void{
        let url = NSURL(string: ALL_MESSAGE_ENDPOINT)
        let request = NSURLRequest(URL: url!)
        let connection: Void = NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!, data: NSData!, error:NSError!)-> Void in
            
            if error != nil {
                var mutableData = NSMutableData(data: data)
                var array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil) as NSArray
                
                for i in array{
                    var dict = i as NSDictionary
                    var origin = dict.valueForKey("origin") as NSString
                    var destination = dict.valueForKey("destination") as NSString
                    var messageType = dict.valueForKey("message_type") as NSString
                    var createdAt = dict.valueForKey("created_at") as NSString
                    var title = dict.valueForKey("title") as NSString
                    var description = dict.valueForKey("description") as NSString
                    
                    let currentMessage = Message(fromOrigin: origin, fromDestination: destination, fromMessageType: messageType, fromTitle: title, fromDescription: description, fromCreatedAt: createdAt)
                    self.messages.append(currentMessage)
                    
                }
            }else{
                println("An error occured while fetching messages from server")
            }
            
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        queryAllMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return messages.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.messages[indexPath.row].description
        return cell;
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showMessageDetailSegue", sender: messages[indexPath.row])
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as MessageDetailViewController;
        
        if segue.identifier == "showMessageDetailSegue" {
            controller.messageDetail = sender as Mensagem
            // todo - alterar a classe
        }
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}

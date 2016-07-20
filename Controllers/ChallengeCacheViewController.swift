//
//  ChallengeCacheViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 28/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ChallengeCacheViewController: UIViewController {

    @IBOutlet weak var cacheLocationMapView: MKMapView!
    @IBOutlet weak var distanceLeftTextField: UITextField!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didPressDoneButton(sender: AnyObject) {
    }
    
    @IBAction func didPressStopButton(sender: AnyObject) {
    }
}

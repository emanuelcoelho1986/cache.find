//
//  DetailCacheViewController.swift
//  cache.find
//
//  Created by Emanuel Coelho on 25/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailCacheViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var selectedCahe:Cache!
    
    @IBOutlet weak var cacheNameTextField: RPFloatingPlaceholderTextField!
    @IBOutlet weak var cacheDescritpionTextView: RPFloatingPlaceholderTextView!
    @IBOutlet weak var cacheLocaltionMapView: MKMapView!
    @IBOutlet weak var startButton: SuccessButton!
    
    var manager:CLLocationManager!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.startButton.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cacheNameTextField.text = selectedCahe.name
        self.cacheDescritpionTextView.text = selectedCahe.descricao
        
        self.cacheDescritpionTextView.editable = false
        self.cacheNameTextField.enabled = false
        
        manager = CLLocationManager()
        manager.delegate = self
        
        //Setup our Location Manager
        if isCLLocationAllowed(){
            manager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        //Setup our Map View
        self.cacheLocaltionMapView.delegate = self
        self.cacheLocaltionMapView.mapType = MKMapType.Standard
        
        // 1
        let location = CLLocationCoordinate2D(
            latitude: NSString(string: selectedCahe.latitude).doubleValue,
            longitude:  NSString(string: selectedCahe.longitude).doubleValue
        )
        
        // 2
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegion(center: location, span: span)
        self.cacheLocaltionMapView.setRegion(region, animated: true)
        
        //3
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = selectedCahe.name
        annotation.subtitle = selectedCahe.oxcode
        self.cacheLocaltionMapView.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressStartButton(sender: AnyObject) {
        NSLog("Dis Press this button: \(kSTART_CHALLENGE_SEGUE)")
        
        //1 - Save Cache Details in CoreData (or other, checking for the best solution)
        
        //X - Present View Controller
        performSegueWithIdentifier(kSTART_CHALLENGE_SEGUE, sender: sender)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    // MARK: - MKMapViewDelegate
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        
    }
    
    // MARK: - CLLocationManagerDelegate
    func isCLLocationAllowed()->Bool{
        var authorizationStatus = CLLocationManager.authorizationStatus()
        
        if CLAuthorizationStatus.Authorized == authorizationStatus || authorizationStatus == CLAuthorizationStatus.AuthorizedWhenInUse{
            return true
        }
        
        return false
    }
    
    func requestUserAuthorizationForLocation(){
        //CLLocationManager.re
    }
    
    func mapViewDidFinishRenderingMap(mapView: MKMapView!, fullyRendered: Bool) {
        self.startButton.hidden = false
    }
}
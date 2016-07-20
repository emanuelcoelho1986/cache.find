//
//  CancelButton.swift
//  cache.find
//
//  Created by Emanuel Coelho on 28/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import UIKit

class CancelButton: UIButton {
    
    override init(){
        super.init()
        
        initButtonStyles()
        
        self.layer.cornerRadius = 4;
        self.tintColor = UIColor.whiteColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initButtonStyles()
        
        self.layer.cornerRadius = 4;
    }
    
    func initButtonStyles(){
        self.backgroundColor = UIColor(red:0.843, green:0.329, blue:0.322, alpha:1.00)
        self.layer.borderColor = UIColor(red: 0.824, green: 0.251, blue: 0.247, alpha: 1.00).CGColor
        self.layer.borderWidth = 1
    }
    
    func initButtonTouched(){
        self.backgroundColor = UIColor(red:0.780, green:0.196, blue:0.196, alpha:1.00)
        self.layer.borderColor = UIColor(red:0.667, green:0.169, blue:0.165, alpha:1.00).CGColor
        self.layer.borderWidth = 1
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        initButtonTouched()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        initButtonStyles()
    }
}

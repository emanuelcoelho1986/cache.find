//
//  SuccessButton.swift
//  cache.find
//
//  Created by Emanuel Coelho on 28/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import UIKit

class SuccessButton: UIButton{
    override init(){
        super.init()
        initButtonStyles()
        initButtonCommonStyles()
    }

    required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        initButtonStyles()
        initButtonCommonStyles()
    }
    
    func initButtonCommonStyles(){
        self.layer.cornerRadius = 4;
        self.tintColor = UIColor.whiteColor()
    }
    
    func initButtonStyles(){
        self.backgroundColor = UIColor(red:0.373, green:0.718, blue:0.376, alpha:1.00)
        self.layer.borderColor = UIColor(red: 0.314, green: 0.678, blue: 0.318, alpha: 1.00).CGColor
        self.layer.borderWidth = 1
        
    }
    
    func initButtonTouched(){
        self.backgroundColor = UIColor(red:0.282, green:0.612, blue:0.282, alpha:1.00)
        self.layer.borderColor = UIColor(red:0.235, green:0.514, blue:0.239, alpha:1.00).CGColor
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
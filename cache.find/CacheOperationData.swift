//
//  CacheOperationData.swift
//  cache.find
//
//  Created by Emanuel Coelho on 16/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation

class CacheOperationData: OperationData {
    
    override init(){
        
    }
    
    /**
    @NSManaged var city: String
    @NSManaged var country: String
    @NSManaged var county: String
    @NSManaged var descricao: String
    @NSManaged var state: String
    @NSManaged var status: NSNumber
    */
    func loadUnknownXML(dataFromFile:NSData) {
        var xmlError:NSErrorPointer
        
        var tbxml = TBXML(XMLData: dataFromFile, error: nil)
        var rootXMLElement = tbxml.rootXMLElement;
        
        var wptElement = TBXML.childElementNamed("wpt", parentElement: rootXMLElement)
        
        do{
            var latitude = TBXML.valueOfAttributeNamed("lat", forElement: wptElement)
            var longitude = TBXML.valueOfAttributeNamed("lon", forElement: wptElement)
            
            var descriptionElement = TBXML.childElementNamed("desc", parentElement: wptElement)
            var descriptionElementText = TBXML.textForElement(descriptionElement)
            
            var oxCodeElement = TBXML.childElementNamed("name", parentElement: wptElement)
            var oxcodeText = TBXML.textForElement(oxCodeElement)
            
            var dataCriacaoElement = TBXML.childElementNamed("time", parentElement: wptElement)
            var dataCriacao = TBXML.textForElement(dataCriacaoElement)
            
            var groundspeakCacheElement = TBXML.childElementNamed("groundspeak:cache", parentElement: wptElement)
            var groundspeakCacheElementText = TBXML.textForElement(groundspeakCacheElement)
            
            var groundspeakNameElement = TBXML.childElementNamed("groundspeak:name", parentElement: groundspeakCacheElement)
            var groundspeakNameText = TBXML.textForElement(groundspeakNameElement)
            
            var groundspeakHintsElement = TBXML.childElementNamed("groundspeak:encoded_hints", parentElement: groundspeakCacheElement)
            var groundspeakHintsText = TBXML.textForElement(groundspeakHintsElement)
            
            var groundspeakDifficulty = TBXML.childElementNamed("groundspeak:difficulty", parentElement: groundspeakCacheElement)
            var groundspeakDifficultyText = TBXML.textForElement(groundspeakDifficulty)
            
            var groundspeakTerrain = TBXML.childElementNamed("groundspeak:terrain", parentElement: groundspeakCacheElement)
            var groundspeakTerrainText = TBXML.textForElement(groundspeakTerrain)
            
            var groundspeakNameCity = TBXML.childElementNamed("groundspeak:name", parentElement: groundspeakCacheElement)
            var groundspeakNameCityText = TBXML.textForElement(groundspeakNameCity)
        
            //Next Element
            wptElement=TBXML.nextSiblingNamed("wpt", searchFromElement: rootXMLElement)
        }while wptElement != nil
        
        
        NSLog("Lol -> Termina Função")
    }
    
    /* For Unknown Attributes and Elements */
    /*func traverseElement(element:TBXMLElement) {
        do{
            // Display the name of the element
            NSLog("\(TBXML.elementName(element))");
            
            // Obtain first attribute from element
            var attribute:TBXMLAttribute = element.firstAttribute
            
            while(attribute){
                // Display name and value of attribute to the log window
                NSLog("\(TBXML.elementName(element))->\(TBXML.attributeName(attribute)) = \(TBXML.attributeValue(attribute))")
                attribute.next
            }
            
        if element.firstChild{
            self.traverseElement(element.firstChild)
            }
        
        }while(element.nextSibling)
    }*/
}
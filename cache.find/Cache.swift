//
//  Cache.swift
//  cache.find
//
//  Created by Emanuel Coelho on 14/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import CoreData

@objc(Cache)
class Cache: NSManagedObject {

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

}

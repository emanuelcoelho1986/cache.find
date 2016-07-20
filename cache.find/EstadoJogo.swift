//
//  EstadoJogo.swift
//  cache.find
//
//  Created by Ivan Frias on 01/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import CoreData

@objc(EstadoJogo)
class EstadoJogo: NSManagedObject {

    @NSManaged var estado: String
    @NSManaged var belongsToJogo: Jogo

}

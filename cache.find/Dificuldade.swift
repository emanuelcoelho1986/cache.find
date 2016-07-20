//
//  Dificuldade.swift
//  cache.find
//
//  Created by Ivan Frias on 01/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import CoreData

@objc(Dificuldade)
class Dificuldade: NSManagedObject {

    @NSManaged var nivelDificuldade: String
    @NSManaged var belongsToDesafio: Desafio

}

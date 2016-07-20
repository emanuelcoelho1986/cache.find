//
//  Jogo.swift
//  cache.find
//
//  Created by Ivan Frias on 01/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import CoreData

@objc(Jogo)
class Jogo: NSManagedObject {

    @NSManaged var avaliacao: String
    @NSManaged var dataFim: NSDate
    @NSManaged var dataInicio: NSDate
    @NSManaged var duracao: NSDecimalNumber
    @NSManaged var hasCache: Cache
    @NSManaged var hasJogadores: Jogador
    @NSManaged var hasDesafios: Desafio
    @NSManaged var hasEstado: EstadoJogo

}

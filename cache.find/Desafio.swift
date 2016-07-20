//
//  Desafio.swift
//  cache.find
//
//  Created by Ivan Frias on 01/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import CoreData

@objc(Desafio)
class Desafio: Mensagem {

    @NSManaged var cache: Cache
    @NSManaged var hasNivelDificuldade: Dificuldade
    @NSManaged var hasJogadores: Jogador
    @NSManaged var hasJogos: Jogo

}

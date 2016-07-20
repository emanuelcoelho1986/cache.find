//
//  Jogador.swift
//  cache.find
//
//  Created by Ivan Frias on 01/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import CoreData

@objc(Jogador)
class Jogador: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var nome: String
    @NSManaged var hasDesafios: NSSet
    @NSManaged var hasJogos: Jogo
    @NSManaged var hasMensagensEnviadas: Mensagem
    @NSManaged var hasMensagensRecebidas: Mensagem

}

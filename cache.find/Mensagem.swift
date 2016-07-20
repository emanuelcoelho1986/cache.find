//
//  Mensagem.swift
//  cache.find
//
//  Created by Ivan Frias on 01/12/14.
//  Copyright (c) 2014 Emanuel Coelho. All rights reserved.
//

import Foundation
import CoreData

@objc(Mensagem)
class Mensagem: NSManagedObject {

    @NSManaged var assunto: String
    @NSManaged var conteudo: String
    @NSManaged var dataEnvio: NSDate
    @NSManaged var dataRececao: NSDate
    @NSManaged var destino: Jogador
    @NSManaged var origem: Jogador

}

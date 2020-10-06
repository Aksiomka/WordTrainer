//
//  WordItem.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 30.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import RealmSwift


class WordItem: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var word = ""
    @objc dynamic var translation = ""
    @objc dynamic var rightAnswers = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

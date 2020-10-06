//
//  Word.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 30.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

struct Word: Equatable, Identifiable {
    let uuid = UUID()
    let id: Int
    let word: String
    let translation: String
    let rightAnswers: Int
}

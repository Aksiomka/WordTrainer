//
//  TrainingInfo.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 24.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


struct TrainingInfo {
    let words: [TrainingWordInfo]
}

struct TrainingWordInfo {
    let word: WordItem
    let answers: [TrainingAnswer]
    let wordToTranslation: Bool
}

struct TrainingAnswer: Equatable, Hashable {
    let answer: String
    let correct: Bool
}

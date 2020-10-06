//
//  TrainingResultViewModel.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 02.07.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class TrainingResultViewModel: ObservableObject {

    @Published var rightAnswers = 0
    @Published var wrongAnswers = 0
    @Published var words: [Word] = []

    init(trainingResult: TrainingResult) {
        words = trainingResult.words.sorted(by: { $0.word < $1.word })
        rightAnswers = trainingResult.numberOfRightAnswers
        wrongAnswers = Constants.NUMBER_OF_STEPS - trainingResult.numberOfRightAnswers
    }
    
}

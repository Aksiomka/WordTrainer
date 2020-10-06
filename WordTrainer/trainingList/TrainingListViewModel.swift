//
//  TrainingListViewModel.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 10.07.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class TrainingListViewModel: ObservableObject {

    @Published var numberOfWordsForTraining = 0
    @Published var numberOfLearnedWords = 0
    @Published var startTrainingButtonDisabled = false
    @Published var startRevisingButtonDisabled = false
    
    private let wordDao: WordDao

    init(wordDao: WordDao) {
        self.wordDao = wordDao
        loadData()
    }
    
    func loadData() {
        let words = wordDao.getWords()
        numberOfLearnedWords = words.filter { $0.rightAnswers >= 100 }.count
        numberOfWordsForTraining = words.count - numberOfLearnedWords
        startTrainingButtonDisabled = numberOfWordsForTraining < 10
        startRevisingButtonDisabled = numberOfLearnedWords < 10
    }
    
}

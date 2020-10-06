//
//  TrainingViewModel.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 31.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class TrainingViewModel: ObservableObject {
    
    @Published var counter = 0
    @Published var word = ""
    @Published var answers: [TrainingAnswer] = []
    @Published var answerButtonsDisabled = false
    @Published var nextButtonDisabled = false
    @Published var showFinishButton = false
    @Published var words: [Word] = []
    @Published var numberOfRightAnswers = 0
    
    private let trainingType: TrainingType
    private var trainingInfo: TrainingInfo!
    
    private let wordDao: WordDao
    
    init(trainingType: TrainingType, wordDao: WordDao) {
        self.trainingType = trainingType
        self.wordDao = wordDao
    }
    
    func fetch() {
        let wordsFromDb = wordDao.getWords()
        trainingInfo = TrainingInfoMaker().makeTrainingInfo(words: wordsFromDb, trainingType: trainingType)
        
        words = trainingInfo.words.map { wordInfo in
            return Word(id: wordInfo.word.id, word: wordInfo.word.word, translation: wordInfo.word.translation, rightAnswers: wordInfo.word.rightAnswers)
        }
        counter = 0
        initTrainingStep()
    }
    
    func answerChosen(answer: TrainingAnswer) {
        if answer.correct {
            numberOfRightAnswers += 1
            let word = trainingInfo.words[counter - 1].word
            wordDao.updateWord(id: word.id, rightAnswers: word.rightAnswers + 1)
        }
        answerButtonsDisabled = true
        nextButtonDisabled = false
    }
    
    func nextTapped() {
        initTrainingStep()
    }
    
    private func initTrainingStep() {
        counter += 1
        
        let wordInfo = trainingInfo.words[counter - 1]
        word = wordInfo.wordToTranslation ? wordInfo.word.word : wordInfo.word.translation
        answers = wordInfo.answers
        
        answerButtonsDisabled = false
        nextButtonDisabled = true
        showFinishButton = counter >= Constants.NUMBER_OF_STEPS
    }
    
}

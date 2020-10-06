//
//  TrainingInfoMaker.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 24.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class TrainingInfoMaker {
    
    func makeTrainingInfo(words: [WordItem], trainingType: TrainingType) -> TrainingInfo {
        let filteredWords = filterWords(words: words, trainingType: trainingType)
        let wordsToTrain = chooseWordsToTrain(words: filteredWords)
        var trainingWords: [TrainingWordInfo] = []
        for wordToTrain in wordsToTrain {
            let wordToTranslation = getRandomBool()
            let answers = makeAnswers(word: wordToTrain, allWords: words, wordToTranslation: wordToTranslation)
            trainingWords.append(TrainingWordInfo(word: wordToTrain, answers: answers, wordToTranslation: wordToTranslation))
        }
        return TrainingInfo(words: trainingWords)
    }
    
    private func chooseWordsToTrain(words: [WordItem]) -> [WordItem] {
        var wordIdsToTrain: [Int] = []
        while wordIdsToTrain.count < Constants.NUMBER_OF_STEPS {
            let randomWord = getRandomWord(words: words)
            if !wordIdsToTrain.contains(randomWord.id) {
                wordIdsToTrain.append(randomWord.id)
            }
        }
        return words.filter { wordItem in wordIdsToTrain.contains(wordItem.id) }
    }
    
    private func makeAnswers(word: WordItem, allWords: [WordItem], wordToTranslation: Bool) -> [TrainingAnswer] {
        var answers: [String] = []
        var result: [TrainingAnswer] = []
        let rightAnswer = wordToTranslation ? word.translation : word.word
        while answers.count < Constants.NUMBER_OF_ANSWERS - 1 {
            let randomWord = getRandomWord(words: allWords)
            let answerString = wordToTranslation ? randomWord.translation : randomWord.word
            let answer = TrainingAnswer(answer: answerString, correct: false)
            if !answers.contains(answerString) && answerString != rightAnswer {
                answers.append(answerString)
                result.append(answer)
            }
        }
        let randomIndex = Int.random(in: 0 ..< Constants.NUMBER_OF_ANSWERS)
        result.insert(TrainingAnswer(answer: rightAnswer, correct: true), at: randomIndex)
        return result
    }
    
    private func getRandomWord(words: [WordItem]) -> WordItem {
        let randomIndex = Int.random(in: 0 ..< words.count)
        return words[randomIndex]
    }
    
    private func getRandomBool() -> Bool {
        let randomIndex = Int.random(in: 0 ... 1)
        return randomIndex == 0 ? false : true
    }
    
    private func filterWords(words: [WordItem], trainingType: TrainingType)  -> [WordItem] {
        return words.filter { word in
            if trainingType == .learning {
                return word.rightAnswers < Constants.LEARNED_BOUND
            } else {
                return word.rightAnswers >= Constants.LEARNED_BOUND
            }
        }
    }
}

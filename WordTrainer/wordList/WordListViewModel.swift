//
//  WordListViewModel.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 31.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class WordListViewModel: ObservableObject {
    
    @Published var words: [Word] = []
    
    private let wordDao: WordDao
    private let userDefaultsStorage: UserDefaultsStorage
    
    init(wordDao: WordDao, userDefaultsStorage: UserDefaultsStorage) {
        self.wordDao = wordDao
        self.userDefaultsStorage = userDefaultsStorage
        loadWords()
    }
    
    func loadWords() {
        let wordsFromDB = wordDao.getWords()
        let sortedWords = sort(words: filter(words: wordsFromDB))
        words = sortedWords.map { wordItem in
            Word(id: wordItem.id, word: wordItem.word, translation: wordItem.translation, rightAnswers: wordItem.rightAnswers)
        }
    }
    
    func deleteWords(indexes: IndexSet) {
        for index in indexes {
            let word = words[index]
            wordDao.deleteWord(id: word.id)
        }
        loadWords()
    }
    
    func onSortingChanged(sorting: Sorting) {
        userDefaultsStorage.saveSorting(sorting)
        loadWords()
    }
    
    func onFilterChanged(filter: Filter) {
        userDefaultsStorage.saveFilter(filter)
        loadWords()
    }
    
    private func sort(words: [WordItem]) -> [WordItem] {
        let sorting = UserDefaultsStorage().loadSorting()
        return words.sorted(by: { word1, word2 in
            if sorting == .alphabetically {
                return word1.word < word2.word
            } else {
                return word1.rightAnswers < word2.rightAnswers
            }
        })
    }
    
    private func filter(words: [WordItem]) -> [WordItem] {
        let filter = UserDefaultsStorage().loadFilter()
        return words.filter { word in
            if filter == .red {
                return word.rightAnswers < 50
            } else if filter == .yellow {
                return word.rightAnswers >= 50 && word.rightAnswers < 100
            } else if filter == .green {
                return word.rightAnswers >= 100
            }
            return true
        }
    }
    
}

//
//  AddWordViewModel.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 29.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class AddWordViewModel: ObservableObject {
    
    @Published var saveButtonDisabled = true
    
    private let wordDao: WordDao
    
    init(wordDao: WordDao) {
        self.wordDao = wordDao
    }
    
    func saveWord(word: String, translation: String) {
        wordDao.addWord(word: word, translation: translation)
    }
    
    func validate(word: String, translation: String) {
        let valid = word != "" && translation != ""
        saveButtonDisabled = !valid
    }
}

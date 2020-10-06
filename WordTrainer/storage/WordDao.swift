//
//  WordDao.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 22.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import RealmSwift


class WordDao {
    
    func addWord(word: String, translation: String) {
        let realm = try! Realm()
        let wordItem = WordItem()
        wordItem.word = word
        wordItem.translation = translation
        try! realm.write {
            let maxId = realm.objects(WordItem.self).max(ofProperty: "id") as Int? ?? 0
            wordItem.id = maxId + 1
            realm.add(wordItem, update: .modified)
        }
    }
    
    func getWords() -> [WordItem] {
        let realm = try! Realm()
        return Array(realm.objects(WordItem.self))
    }
    
    func getNotLearnedWords() -> [WordItem] {
        let realm = try! Realm()
        return Array(realm.objects(WordItem.self).filter("rightAnswers < 100"))
    }
    
    func updateWord(id: Int, rightAnswers: Int) {
        let realm = try! Realm()
        try! realm.write {
            if let wordItem = realm.objects(WordItem.self).filter("id == %d", id).first {
                wordItem.rightAnswers = rightAnswers
                realm.add(wordItem, update: .modified)
            }
        }
    }
    
    func deleteWord(id: Int) {
        let realm = try! Realm()
        try! realm.write {
            if let wordItem = realm.objects(WordItem.self).filter("id == %d", id).first {
                realm.delete(wordItem)
            }
        }
    }
    
}

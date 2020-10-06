//
//  UserDefaultsStorage.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 21.08.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class UserDefaultsStorage {
    
    private let SORTING_KEY = "sorting"
    private let FILTER_KEY = "filter"
    
    func saveSorting(_ sorting: Sorting) {
        UserDefaults.standard.set(sorting.rawValue, forKey: SORTING_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func loadSorting() -> Sorting {
        let sortingStr = UserDefaults.standard.string(forKey: SORTING_KEY) ?? ""
        return Sorting(rawValue: sortingStr) ?? .alphabetically
    }
    
    func saveFilter(_ filter: Filter) {
        UserDefaults.standard.set(filter.rawValue, forKey: FILTER_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func loadFilter() -> Filter {
        let filterStr = UserDefaults.standard.string(forKey: FILTER_KEY) ?? ""
        return Filter(rawValue: filterStr) ?? .all
    }
}

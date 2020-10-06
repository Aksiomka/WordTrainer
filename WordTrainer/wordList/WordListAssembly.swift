//
//  WordListAssembly.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 31.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Swinject


class WordListAssembly: Assembly {
    
    func build() -> WordListView {
        return AppAssembly.assembler.resolver.resolve(WordListView.self)!
    }
    
    func assemble(container: Container) {
        container.register(WordListViewModel.self) { (r) in
            return WordListViewModel(
                wordDao: r.resolve(WordDao.self)!,
                userDefaultsStorage: r.resolve(UserDefaultsStorage.self)!
            )
        }
        container.register(WordListView.self) { r in
            return WordListView(viewModel: r.resolve(WordListViewModel.self)!)
        }
    }
    
}


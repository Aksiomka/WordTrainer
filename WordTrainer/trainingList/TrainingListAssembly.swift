//
//  TrainingListAssembly.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 10.07.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Swinject


class TrainingListAssembly: Assembly {
    
    func build() -> TrainingListView {
        return AppAssembly.assembler.resolver.resolve(TrainingListView.self)!
    }
    
    func assemble(container: Container) {
        container.register(TrainingListViewModel.self) { (r) in
            return TrainingListViewModel(wordDao: r.resolve(WordDao.self)!)
        }
        container.register(TrainingListView.self) { r in
            return TrainingListView(viewModel: r.resolve(TrainingListViewModel.self)!)
        }
    }
}

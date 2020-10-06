//
//  TrainingAssembly.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 31.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Swinject


class TrainingAssembly: Assembly {
    
    func build(trainingType: TrainingType) -> TrainingView {
        return AppAssembly.assembler.resolver.resolve(TrainingView.self, argument: trainingType)!
    }
    
    func assemble(container: Container) {
        container.register(TrainingViewModel.self) { (r, trainingType: TrainingType) in
            return TrainingViewModel(trainingType: trainingType, wordDao: r.resolve(WordDao.self)!)
        }
        container.register(TrainingView.self) { (r, trainingType: TrainingType) in
            return TrainingView(viewModel: r.resolve(TrainingViewModel.self, argument: trainingType)!)
        }
    }
    
}

//
//  TrainingResultAssembly.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 02.07.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Swinject


class TrainingResultAssembly: Assembly {
    
    func build(trainingResult: TrainingResult) -> TrainingResultView {
        return AppAssembly.assembler.resolver.resolve(TrainingResultView.self, argument: trainingResult)!
    }
    
    func assemble(container: Container) {
        container.register(TrainingResultViewModel.self) { (r, trainingResult: TrainingResult) in
            return TrainingResultViewModel(trainingResult: trainingResult)
        }
        container.register(TrainingResultView.self) { (r, trainingResult: TrainingResult) in
            return TrainingResultView(viewModel: r.resolve(TrainingResultViewModel.self, argument: trainingResult)!)
        }
    }
}

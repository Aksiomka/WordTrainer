//
//  AppAssembly.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 30.09.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Swinject


final class AppAssembly {
    
    class var assembler: Assembler {
        return Assembler([
                CommonAssembly(),
                WordListAssembly(),
                AddWordPopupAssembly(),
                TrainingAssembly(),
                TrainingListAssembly(),
                TrainingResultAssembly()
            ])
    }
    
}

//
//  CommonAssembly.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 30.09.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Swinject


public class CommonAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TrainingInfoMaker.self) { _ in TrainingInfoMaker() }
        container.register(WordDao.self) { _ in WordDao() }
        container.register(UserDefaultsStorage.self) { _ in UserDefaultsStorage() }
    }
}

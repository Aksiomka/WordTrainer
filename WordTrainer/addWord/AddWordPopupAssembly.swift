//
//  AddWordPopupAssembly.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 21.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Swinject


class AddWordPopupAssembly: Assembly {
    
    func build(closePopupCallback: @escaping () -> Void) -> AddWordPopup {
        var view = AppAssembly.assembler.resolver.resolve(AddWordPopup.self)!
        view.closePopupCallback = closePopupCallback
        return view
    }
    
    func assemble(container: Container) {
        container.register(AddWordViewModel.self) { (r) in
            return AddWordViewModel(wordDao: r.resolve(WordDao.self)!)
        }
        container.register(AddWordPopup.self) { r in
            return AddWordPopup(viewModel: r.resolve(AddWordViewModel.self)!)
        }
    }
    
}

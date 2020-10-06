//
//  ContentViewData.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 12.07.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class ContentViewData: ObservableObject {
    
    @Published var activeTrainingType: TrainingType? = nil
    @Published var trainingResult: TrainingResult? = nil
    @Published var showingAddWordPopup = false
    
}

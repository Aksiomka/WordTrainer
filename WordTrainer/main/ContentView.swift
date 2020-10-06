//
//  ContentView.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 30.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewData = ContentViewData()
    
    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                    WordListAssembly().build()
                }
                    .environmentObject(contentViewData)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Word list")
                    }.tag(0)
                NavigationView {
                    TrainingListAssembly().build()
                }
                    .environmentObject(contentViewData)
                    .tabItem {
                        Image(systemName: "checkmark.seal")
                        Text("Training")
                    }.tag(1)
            }
            
            if contentViewData.activeTrainingType != nil {
                TrainingAssembly().build(trainingType: contentViewData.activeTrainingType!).environmentObject(contentViewData)
            }
            if contentViewData.trainingResult != nil {
                TrainingResultAssembly().build(trainingResult: contentViewData.trainingResult!)
                    .environmentObject(contentViewData)
            }
            if contentViewData.showingAddWordPopup {
                AddWordPopupAssembly().build(closePopupCallback: {
                    self.contentViewData.showingAddWordPopup = false
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

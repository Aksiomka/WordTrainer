//
//  TrainingListView.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 28.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct TrainingListView: View {
    @ObservedObject var viewModel: TrainingListViewModel
    
    @EnvironmentObject var contentViewData: ContentViewData
    
    @State private var showingCannotStartTrainingAlert = false
    @State private var showingCannotStartRevisingAlert = false
    
    var body: some View {
        VStack {
            Spacer().frame(height: 32)
            Text("Words for training: \(viewModel.numberOfWordsForTraining)")
            Spacer().frame(height: 4)
            Text("Learned words: \(viewModel.numberOfLearnedWords)")
            Spacer().frame(height: 32)
            Button(action: {
                if !self.viewModel.startTrainingButtonDisabled {
                    self.contentViewData.activeTrainingType = .learning
                } else {
                    self.showingCannotStartTrainingAlert = true
                }
            }, label: {
                Text("Train new words")
                .frame(width: 200, height: 40, alignment: .center)
                .background(Color.white)
                    .foregroundColor(viewModel.startTrainingButtonDisabled ? Color.gray : Color.blue)
                .cornerRadius(19)
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                .background(viewModel.startTrainingButtonDisabled ? Color.gray : Color.blue)
                .cornerRadius(20)
            })
            .alert(isPresented: $showingCannotStartTrainingAlert) {
                Alert(title: Text("Cannot start training"), message: Text("Add more words"), dismissButton: .default(Text("OK")))
            }
            Spacer().frame(height: 16)
            Button(action: {
                if !self.viewModel.startRevisingButtonDisabled {
                    self.contentViewData.activeTrainingType = .revising
                } else {
                    self.showingCannotStartRevisingAlert = true
                }
            }, label: {
                Text("Revise learned words")
                .frame(width: 200, height: 40, alignment: .center)
                .background(Color.white)
                .foregroundColor(viewModel.startRevisingButtonDisabled ? Color.gray : Color.blue)
                .cornerRadius(19)
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                .background(viewModel.startRevisingButtonDisabled ? Color.gray : Color.blue)
                .cornerRadius(20)
            })
            .alert(isPresented: $showingCannotStartRevisingAlert) {
                Alert(title: Text("Cannot start revising"), message: Text("Learn more words"), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
        .onAppear {
            self.viewModel.loadData()
        }
        .navigationBarTitle(Text("Training"), displayMode: .inline)
    }
}

struct TrainingListView_Previews: PreviewProvider {
    static var previews: some View {
        let wordDao = WordDao()
        let viewModel = TrainingListViewModel(wordDao: wordDao)
        return TrainingListView(viewModel: viewModel)
    }
}

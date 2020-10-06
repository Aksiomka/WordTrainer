//
//  TrainingResultView.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 02.07.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct TrainingResultView: View {
    
    @ObservedObject var viewModel: TrainingResultViewModel
    
    @EnvironmentObject var contentViewData: ContentViewData
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 8)
                Text("Training Results").font(.title)
                Spacer().frame(height: 16)
                Text("Right answers: \(viewModel.rightAnswers)")
                Text("Wrong answers: \(viewModel.wrongAnswers)")
                List {
                    ForEach(viewModel.words, id: \.id) { word in
                        WordRow(word: word)
                    }
                }
                Button(action: {
                    self.contentViewData.trainingResult = nil
                }, label: {
                    Text("OK")
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                })
            }
        }
    }
}

struct TrainingResultView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TrainingResultViewModel(trainingResult: TrainingResult(words: [], numberOfRightAnswers: 0))
        return TrainingResultView(viewModel: viewModel)
    }
}

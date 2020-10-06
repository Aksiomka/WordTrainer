//
//  TrainingView.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 31.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct TrainingView: View {
    @ObservedObject var viewModel: TrainingViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var contentViewData: ContentViewData
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Spacer().frame(height: 32)
                    Text("Task \(viewModel.counter)")
                        .bold()
                    Spacer().frame(height: 16)
                    Text("Choose a right translation")
                        .font(.subheadline)
                        .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                    Spacer().frame(height: 40)
                    Text(viewModel.word)
                        .font(.largeTitle).bold()
                }
                Spacer()
                ForEach(viewModel.answers, id: \.self) { answer in
                    Button(action: {
                        self.viewModel.answerChosen(answer: answer)
                    }, label: {
                        Text(answer.answer)
                        .frame(width: 200, height: 40, alignment: .center)
                        .background(self.getAnswerButtonBgColor(answer: answer))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding()
                    })
                    .disabled(self.viewModel.answerButtonsDisabled)
                }
                Spacer()
                if !viewModel.showFinishButton {
                    Button(action: {
                        self.viewModel.nextTapped()
                    }, label: {
                        Text("Next")
                        .frame(width: 200, height: 40, alignment: .center)
                            .background(viewModel.nextButtonDisabled ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    })
                    .disabled(self.viewModel.nextButtonDisabled)
                } else {
                    Button(action: {
                        self.contentViewData.activeTrainingType = nil
                        self.contentViewData.trainingResult = TrainingResult(words: self.viewModel.words, numberOfRightAnswers: self.viewModel.numberOfRightAnswers)
                    }, label: {
                        Text("Finish")
                        .frame(width: 200, height: 40, alignment: .center)
                            .background(viewModel.nextButtonDisabled ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    })
                    .disabled(self.viewModel.nextButtonDisabled)
                }
                Spacer()
            }
        }
        .onAppear(perform: viewModel.fetch)
    }
    
    private func getAnswerButtonBgColor(answer: TrainingAnswer) -> Color {
        self.viewModel.answerButtonsDisabled ? (answer.correct ? Color("rightColor") : Color("wrongAnswerColor")) : Color.blue
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        let wordDao = WordDao()
        let viewModel = TrainingViewModel(trainingType: .learning, wordDao: wordDao)
        viewModel.word = "word"
        viewModel.answers = [
            TrainingAnswer(answer: "a", correct: false),
            TrainingAnswer(answer: "b", correct: false),
            TrainingAnswer(answer: "слово", correct: false),
            TrainingAnswer(answer: "c", correct: false)]
        return TrainingView(viewModel: viewModel)
    }
}

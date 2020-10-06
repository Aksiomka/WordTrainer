//
//  WordRow.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 30.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WordRow : View {
    var word: Word

    var body: some View {
        HStack {
            Circle()
                .fill(getCircleColor())
                .frame(width: 20, height: 20)
            VStack(alignment: .leading) {
                Text(word.word)
                Text(word.translation)
                    .font(Font.system(size: 12))
                    .foregroundColor(Color.gray)
            }
        }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
    
    private func getCircleColor() -> Color {
        if word.rightAnswers >= 100 {
            return Color.green
        } else if word.rightAnswers >= 50 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
}

struct WordRow_Previews: PreviewProvider {
    static var previews: some View {
        WordRow(word: Word(id: 0, word: "word", translation: "слово", rightAnswers: 0))
    }
}

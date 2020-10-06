//
//  AddWordPopup.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 29.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct AddWordPopup: View {
    
    @ObservedObject var viewModel: AddWordViewModel
    
    @ObservedObject private var keyboard = KeyboardObserver()
    
    @State var word = ""
    @State var translation = ""
    
    var closePopupCallback: () -> Void = {}
    
    var body: some View {
        let wordBinding = Binding<String>(get: {
            self.word
        }, set: {
            self.word = $0
            self.textChanged()
        })
        
        let translationBinding = Binding<String>(get: {
            self.translation
        }, set: {
            self.translation = $0
            self.textChanged()
        })
        
        return ZStack{
            Rectangle()
            .fill(Color.gray)
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.closePopupCallback()
            }

            VStack {
                Text("Add word")
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .foregroundColor(Color.white)
                Spacer()
                TextField("Word", text: wordBinding).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                TextField("Translation", text: translationBinding).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                Spacer()
                HStack {
                    Spacer().frame(width: 16)
                    Button(action: {
                        self.closePopupCallback()
                    }) {
                        Text("Cancel")
                            .frame(width: 120, height: 40, alignment: .center)
                            .background(Color(red: 1.0, green: 0.3, blue: 0.3))
                            .foregroundColor(Color.white)
                            .cornerRadius(12)
                    }
                    Spacer()
                    Button(action: {
                        self.viewModel.saveWord(word: self.word, translation: self.translation)
                        self.closePopupCallback()
                    }) {
                        Text("Save")
                        .frame(width: 120, height: 40, alignment: .center)
                            .background(self.viewModel.saveButtonDisabled ? Color.gray : Color(red: 0.3, green: 0.3, blue: 0.3))
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                    }
                    .disabled(self.viewModel.saveButtonDisabled)
                    Spacer().frame(width: 16)
                }
                Spacer()
            }
            .frame(minWidth: 300, idealWidth: 300, maxWidth: 300, minHeight: 250, idealHeight: 250, maxHeight: 250, alignment: .top)
            .fixedSize(horizontal: true, vertical: true)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .offset(y: keyboard.offset).animation(.easeInOut(duration: 0.7))
        }
        .onAppear { self.keyboard.addObserver() }
        .onDisappear { self.keyboard.removeObserver() }
    }
    
    private func textChanged() {
        viewModel.validate(word: word, translation: translation)
    }
    
}

struct AddWordPopup_Previews: PreviewProvider {
    static var previews: some View {
        let wordDao = WordDao()
        let viewModel = AddWordViewModel(wordDao: wordDao)
        return AddWordPopup(viewModel: viewModel)
    }
}

//
//  WordListView.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 30.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WordListView: View {
    @ObservedObject var viewModel: WordListViewModel
    @State private var showingDeleteAlert = false
    @State private var indexSetToDelete: IndexSet?
    @EnvironmentObject var contentViewData: ContentViewData
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        self.viewModel.onSortingChanged(sorting: .alphabetically)
                    }, label: {
                        Image("sort-alphabetically")
                    })
                    Button(action: {
                        self.viewModel.onSortingChanged(sorting: .byProgress)
                    }, label: {
                        Image("sort-by-progress")
                    })
                    Spacer()
                    Button(action: {
                        self.viewModel.onFilterChanged(filter: .red)
                    }, label: {
                        Circle()
                            .fill(Color.red)
                        .frame(width: 20, height: 20)
                    })
                    Button(action: {
                        self.viewModel.onFilterChanged(filter: .yellow)
                    }, label: {
                        Circle()
                            .fill(Color.yellow)
                        .frame(width: 20, height: 20)
                    })
                    Button(action: {
                        self.viewModel.onFilterChanged(filter: .green)
                    }, label: {
                        Circle()
                            .fill(Color.green)
                        .frame(width: 20, height: 20)
                    })
                    Button(action: {
                        self.viewModel.onFilterChanged(filter: .all)
                    }, label: {
                        Text("All")
                    })
                }.padding()
                    .background(Color.init(red: 0.97, green: 0.97, blue: 0.97))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                    .background(Color.gray)
                if viewModel.words.count > 0 {
                    List {
                        ForEach(viewModel.words, id: \.id) { word in
                            WordRow(word: word)
                        }.onDelete(perform: { indexSet in
                            self.indexSetToDelete = indexSet
                            self.showingDeleteAlert = true
                        })
                        AddWordRow(addWordButtonTappedCallback: {
                            self.contentViewData.showingAddWordPopup = true
                        })
                    }
                    .alert(isPresented: self.$showingDeleteAlert) {
                        let indexSet = self.indexSetToDelete!
                        return Alert(title: Text("Confirmation"), message: Text("Are you sure you want to delete this word?"),
                          primaryButton: .cancel(),
                          secondaryButton: .destructive(Text("Delete")) {
                            self.deleteWords(at: indexSet)
                        })
                    }
                } else {
                    Text("There are no words")
                        .foregroundColor(.gray)
                        .padding()
                    List {
                        AddWordRow(addWordButtonTappedCallback: {
                            self.contentViewData.showingAddWordPopup = true
                        })
                    }
                }
            }
        }.animation(.easeInOut)
        .onAppear {
            UITableView.appearance().tableFooterView = UIView()
            self.viewModel.loadWords()
        }
        .navigationBarTitle(Text("Word list"), displayMode: .inline)
    }
    
    func deleteWords(at offsets: IndexSet) {
        viewModel.deleteWords(indexes: offsets)
    }
}

struct WordList_Previews: PreviewProvider {
    static var previews: some View {
        let words = [Word(id: 0, word: "food", translation: "еда", rightAnswers: 0),
                     Word(id: 1, word: "place", translation: "место", rightAnswers: 0),
                     Word(id: 2, word: "cat", translation: "кошка", rightAnswers: 0)]
        let wordDao = WordDao()
        let userDefaultsStorage = UserDefaultsStorage()
        let viewModel = WordListViewModel(wordDao: wordDao, userDefaultsStorage: userDefaultsStorage)
        viewModel.words = words
        return WordListView(viewModel: viewModel)
    }
}

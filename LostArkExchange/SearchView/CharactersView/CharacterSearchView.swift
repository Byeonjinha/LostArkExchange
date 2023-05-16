//
//  CharacterSearchView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/17.
//

import SwiftUI

struct CharacterSearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: CharacterNameEntity.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \CharacterNameEntity.timestamp, ascending: true)] )
    var characterNameDatas: FetchedResults<CharacterNameEntity>
    
    @Binding var searchCharacter: String
    @StateObject private var searchCharacters = CharactersAPI.shared
    
    @State private var isBookmarkOn: Bool = false
    @State private var isAddConditionOn: Bool = false
    @ObservedObject var addConditionName = TextLimiter(limit: 16)
    
    @State private var showingServerAlert: Bool = false
    @State private var showingTextNullAlert: Bool = false
    
    public func addItem(characterName: String) {
        let newData = CharacterNameEntity(context: viewContext)
        newData.characterName = characterName
        newData.timestamp = Date()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { characterNameDatas[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Color.defaultBlue
                        .cornerRadius(5)
                        .frame(width: w * 0.6, height: h * 0.05)
                        .overlay(
                            HStack {
                                TextField("" , text : $searchCharacter)
                                    .placeholder(when: searchCharacter.isEmpty) {
                                        Text("캐릭터명")
                                            .foregroundColor(.gray)
                                    }
                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                Button(action:{
                                    searchCharacters.posts = []
                                    searchCharacters.getMyIP(characterID: searchCharacter)
                                })
                                {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 15, height: 15)
                                }
                            }
                                .padding()
                        )
                        .padding()
                                    Button(action:{
                                        self.addConditionName.value = ""
                                        self.isAddConditionOn = true
                                    }){
                                        Image(systemName: "plus.square.fill")
                                    }
                                    Button(action:{
                                        self.isBookmarkOn = true
                                    }){
                                        Image(systemName: "bookmark.fill")
                                    }
                }
                List {
                    if !searchCharacters.posts.isEmpty {
                        if searchCharacters.posts[0] != nil {
                            ForEach(searchCharacters.posts[0]!.indices , id: \.self) { idx in
                                Section(header: Text("캐릭터명"), content: {
                                    
                                    let gameData: GameData = GameData(itemMaxLevel: String(searchCharacters.posts[0]![idx].characterLevel),
                                                                      characterClassName: searchCharacters.posts[0]![idx].characterClassName ?? "0",
                                                                      serverName: searchCharacters.posts[0]![idx].serverName,
                                                                      characterName: searchCharacters.posts[0]![idx].characterName,
                                                                      characterLevel: searchCharacters.posts[0]![idx].itemMaxLevel ?? "0")
                                    CharacterStatusView(gameData: gameData)
                                }
                                )
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            if isAddConditionOn {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .onTapGesture {
                            self.isAddConditionOn = false
                        }
                    if #available(iOS 16.0, *) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: w * 0.8 , height: h * 0.2)
                            .overlay(
                                VStack {
                                    Text("캐릭터명 저장")
                                        .foregroundColor(Color.defaultBlue)
                                    HStack {
                                        Color.defaultBlue
                                            .cornerRadius(5)
                                            .frame(width: w * 0.6, height: h * 0.05)
                                            .overlay(
                                                TextField("" , text : $addConditionName.value)
                                                    .placeholder(when: addConditionName.value.isEmpty) {
                                                        Text("캐릭터명")
                                                            .foregroundColor(.gray)
                                                    }
                                                    .padding()
                                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                                                    .foregroundColor(.gray)
                                            )
                                        Button(action: {
                                            if addConditionName.value.isEmpty {
                                                showingTextNullAlert.toggle()
                                            } else {
                                                addItem(characterName: self.addConditionName.value)
                                                self.isAddConditionOn = false
                                            }
                                        })
                                        {
                                            Image(systemName: "plus.square")
                                                .alert("주의", isPresented: $showingTextNullAlert) {
                                                    Button("Ok") {}
                                                } message: {
                                                    Text("캐릭터명을 공백으로 저장할 수 없습니다.")
                                                }
                                        }
                                    }
                                }
                            )
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            if isBookmarkOn {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .onTapGesture {
                            self.isBookmarkOn = false
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: w * 0.8 , height: h * 0.5)
                        .overlay(
                            List {
                                ForEach(characterNameDatas.indices , id: \.self) {idx in
                                    Button(action:{
                                        self.isBookmarkOn = false
                                        searchCharacters.posts = []
                                        searchCharacters.getMyIP(characterID: characterNameDatas[idx].characterName!)
                                    })
                                    {
                                        Rectangle()
                                            .alert("주의", isPresented: $showingServerAlert) {
                                                Button("Ok") {}
                                            } message: {
                                                Text("서버 정보를 받을 수 없습니다.")
                                            }
                                            .foregroundColor(.clear)
                                            .overlay(
                                                Text(characterNameDatas[idx].characterName!)
                                            )
                                    }
                                }
                                .onDelete(perform: deleteItems)
                            }
                                .opacity(0.9)
                        )
                }
            }
        }
    }
}

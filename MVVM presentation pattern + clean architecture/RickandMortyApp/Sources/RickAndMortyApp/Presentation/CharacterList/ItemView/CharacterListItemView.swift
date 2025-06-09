//
//  CharacterListItemView.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI
import SDWebImageSwiftUI


struct CharacterListItemView: View {
    let item: CharacterListPresentableItem
    var body: some View {
        HStack{
            Text(item.name)
                .frame(maxWidth: .infinity, alignment: .leading)
            WebImage(url: URL(string: item.image))
                .resizable()
                .placeholder(Image(systemName: "Character"))
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
                .cornerRadius(8.0)
        }.padding(10)
    }
}

struct CharacterListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListItemView(item: item)
    }
}

let domainModel = Characters.Result(id: 0,
                                    name: "Rick Sanchez",
                                    status: .alive,
                                    species: .human,
                                    type: "",
                                    gender: .male,
                                    origin: .init(name: "Earth (C-137)",
                                                  url: "https://rickandmortyapi.com/api/location/1"),
                                    location: Characters.Location.init(name: "Citadel of Ricks",
                                                                       url: "https://rickandmortyapi.com/api/location/3"),
                                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                    url: "",
                                    created: "")
let item = CharacterListPresentableItem(domainModel: domainModel)

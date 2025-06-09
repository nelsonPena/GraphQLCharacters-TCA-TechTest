//
//  CharacterListItemView.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI
import SDWebImageSwiftUI
import Entities


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

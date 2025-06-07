//
//  CharacterCell.swift
//  TCA Technical Test
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import SwiftUI
import ComposableArchitecture

import SwiftUI
import ComposableArchitecture

struct CharacterCell: View {
    
    let store: StoreOf<CharacterItemDomain>
    
    var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: store.character.image)) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemGray5))
                                .frame(width: 80, height: 80)
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .failure:
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemGray5))
                                .frame(width: 80, height: 80)
                            Image(systemName: "xmark.octagon.fill")
                                .foregroundColor(.red)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(store.character.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(store.character.species)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Status: \(store.character.status)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
            .contentShape(Rectangle())
            .onTapGesture {
                store.send(.didTap)
            }
        }
    }
}

#Preview {
    CharacterCell(
        store: Store(
            initialState: CharacterItemDomain.State(
                id: UUID(),
                character: Character.sample.first!
            ),
            reducer: { CharacterItemDomain() }
        )
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}

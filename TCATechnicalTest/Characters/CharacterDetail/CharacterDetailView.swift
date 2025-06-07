//
//  CharacterDetailView.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import SwiftUI
import ComposableArchitecture

struct CharacterDetailView: View {
    @Bindable var store: StoreOf<CharacterDetailDomain>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                if let character = store.character {
                    ScrollView {
                        VStack(alignment: .center, spacing: 20) {
                            CharacterImageView(url: character.image)
                                .padding(.top, 20)
                            Text(character.name)
                                .font(.system(size: 30, weight: .bold))
                                .accessibilityIdentifier("nameLabel")
                                .foregroundColor(.black)
                            
                            DetailRow(label: "text_gender".localized, value: character.gender)
                            DetailRow(label: "text_origin".localized, value: character.originName)
                            DetailRow(label: "text_localization".localized, value: character.locationName)
                            DetailRow(label: "text_creation_date".localized, value: character.created)
                            DetailRow(label: "text_species".localized, value: character.species)
                            DetailRow(label: "text_status".localized, value: character.status, isStatus: true)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                    DoneButton(action: {
                        store.send(.didPressCloseButton)
                    })
                    .padding()
                    
                } else {
                    ProgressView().progressViewStyle(.circular)
                }
            }
            .navigationBarTitle("detail_title".localized, displayMode: .large)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct CharacterImageView: View {
    let url: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: url)
        ) {
            $0
                .resizable()
            
        } placeholder: {
            Rectangle().foregroundColor(.gray)
        }
        .scaledToFill()
        .frame(width: 200, height: 200)
        .cornerRadius(8)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    var isStatus: Bool = false
    
    var body: some View {
        HStack {
            Text(label)
                .accessibilityIdentifier("text_\(label.lowercased())")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .bold))
            
            Text(value)
                .accessibilityIdentifier("value_\(label.lowercased())")
                .foregroundColor(isStatus ? getStatusColor(value) : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func getStatusColor(_ status: String) -> Color {
        return status == "text_alive_status".localized ? .green : .red
    }
}

struct DoneButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("text_done_button".localized)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .accessibilityIdentifier("doneButton")
        .padding()
        .background(Color.accentColor)
        .cornerRadius(100)
    }
}

#Preview {
    CharacterDetailView(
        store: Store(
            initialState: CharacterDetailDomain.State(character: .preview),
            reducer: { CharacterDetailDomain() }
        )
    )
}

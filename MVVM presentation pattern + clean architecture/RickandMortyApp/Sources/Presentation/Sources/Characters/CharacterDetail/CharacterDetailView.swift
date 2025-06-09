//
//  CharacterDetailView.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI
import SDWebImageSwiftUI
import Entities
import Helpers

/// Vista de detalles de un personaje en Rick and Morty
public struct CharacterDetailView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel: CharacterDetailViewModel
    @ObservedObject var state: CharacterDetailState
    
    public init(viewModel: CharacterDetailViewModel, state: CharacterDetailState) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.state = state
    }
    
    // MARK: - Body
    public var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView().progressViewStyle(.circular)
            } else {
                content
            }
        }
        .navigationBarTitle("detail_title".localized, displayMode: .large)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Content View
    @ViewBuilder
    private var content: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                CharacterImageView(url: viewModel.characterDetailPresentable.image)
                
                Text(viewModel.characterDetailPresentable.name)
                    .font(.system(size: 30, weight: .bold))
                    .accessibilityIdentifier("nameLabel")
                    .foregroundColor(.black)
                
                // Detail Rows
                DetailRow(label: "text_gender".localized, value: viewModel.characterDetailPresentable.gender)
                DetailRow(label: "text_origin".localized, value: viewModel.characterDetailPresentable.originName)
                DetailRow(label: "text_localization".localized, value: viewModel.characterDetailPresentable.locationName)
                DetailRow(label: "text_creation_date".localized, value: viewModel.characterDetailPresentable.created)
                DetailRow(label: "text_species".localized, value: viewModel.characterDetailPresentable.species)
                DetailRow(label: "text_status".localized, value: viewModel.characterDetailPresentable.status, isStatus: true)
                
                Spacer()
            }
            .padding()
        }
        
        DoneButton(action: {  state.didTapDone = true })
            .padding()
    }
}

// MARK: - Character Image View
/// Vista para mostrar la imagen de un personaje con soporte para carga diferida y placeholder
struct CharacterImageView: View {
    let url: String
    
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: 200, height: 200)
            .cornerRadius(8)
    }
}

// MARK: - Detail Row View
/// Vista genérica para mostrar una fila de detalles de un personaje
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
    
    /// Retorna el color adecuado según el estado del personaje
    private func getStatusColor(_ status: String) -> Color {
        return status == "text_alive_status".localized ? .green : .red
    }
}

// MARK: - Done Button View
/// Botón de acción para cerrar la vista de detalle
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
        .background(Color.purple)
        .cornerRadius(100)
    }
}

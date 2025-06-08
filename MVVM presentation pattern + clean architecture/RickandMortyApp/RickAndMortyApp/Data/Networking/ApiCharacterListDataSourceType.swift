//
//  ApiLoginDataSourceType.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine

protocol ApiCharacterListDataSourceType {
    func GetCharactersList() -> AnyPublisher<CharactersDTO.ResponseDTO, HttpClientError>
}

//
//  APIModels.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//


typealias StringArray = [String]

struct License: Decodable {
    let name: String
    let url: String
}

struct Phonetic: Decodable {
    let text: String?
    let audio: String?
    let sourceUrl: String?
    let license: License?
}

struct Definition: Decodable {
    let definition: String
    let synonyms: StringArray
    let antonyms: StringArray
    let example: String?
}

struct Meaning: Decodable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms: StringArray
    let antonyms: StringArray
}

/// Main API response object
struct DictionaryAPIModel: Decodable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetic]
    let meanings: [Meaning]
    let license: License
    let sourceUrls: [String]
}

//
//  Hero.swift
//  HeroesApp
//
//  Created by Alex Kulish on 17.02.2022.
//

import Foundation

// MARK: - Welcowe element

struct Hero: Codable {
    let id: Int
    let name, slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images
}

// MARK: - Powerstats

struct Powerstats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

// MARK: - Appearance

struct Appearance: Codable {
    let gender: Gender
//    let race: String
    let height, weight: [String]
    let eyeColor: String
    let hairColor: String
}

enum Gender: String, Codable {
    case empty = "-"
    case female = "Female"
    case male = "Male"
}

// MARK: - Biography

struct Biography: Codable {
//    let fullname: String
    let alterEgos: String
    let aliases: [String]
    let placeOfBirth: String
    let firstAppearance: String
//    let publisher: String
    let alignment: Alignment
}

enum Alignment: String, Codable {
    case bad = "bad"
    case empty = "-"
    case good = "good"
    case neutral = "neutral"
}

// MARK: - Work

struct Work: Codable {
    let occupation, base: String
}

// MARK: - Connections

struct Connections: Codable {
    let groupAffiliation, relatives: String
}

// MARK: - Images

struct Images: Codable {
    let xs, sm, md, lg: String
}

//
//  Channel.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/18/20.
//

import Foundation

struct Channel: Codable {
    public let id: String
    public let title: String
    public let description: String
    public let dj: String
    public let djmail: String
    public let genre: String
    public let image: String
    public let largeimage: String?
    public let xlimage: String
//    public let twitter: String
    public let updated: String
    public let playlists: [PlayList]
    public let listeners: String
    public let lastPlaying: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case dj
        case djmail
        case genre
        case image
        case largeimage
        case xlimage
//        case twitter
        case updated
        case playlists
        case listeners
        case lastPlaying
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        dj = try container.decode(String.self, forKey: .dj)
        djmail = try container.decode(String.self, forKey: .djmail)
        genre = try container.decode(String.self, forKey: .genre)
        image = try container.decode(String.self, forKey: .image)
        largeimage = try container.decodeIfPresent(String.self, forKey: .largeimage) ?? ""
        xlimage = try container.decode(String.self, forKey: .xlimage)
//        twitter = try container.decode(String.self, forKey: .twitter)
        updated = try container.decode(String.self, forKey: .updated)
        playlists = try container.decode([PlayList].self, forKey: .playlists)
        listeners = try container.decode(String.self, forKey: .listeners)
        lastPlaying = try container.decode(String.self, forKey: .lastPlaying)
    }
}

struct PlayList: Codable {
    public let url: String
    public let format: String
    public let quality: String
    enum CodingKeys: String, CodingKey {
        case url
        case format
        case quality
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        format = try container.decode(String.self, forKey: .format)
        quality = try container.decode(String.self, forKey: .quality)
    }
    
}

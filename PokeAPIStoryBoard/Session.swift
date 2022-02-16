//
//  Session.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import Foundation

class Session: Codable {
    static let current = Session()
    private static let KArchiveKey = "ArchiveKey"
    
    var username: String?
    var token: String?
    
    
}

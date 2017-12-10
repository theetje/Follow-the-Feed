//
//  UserModel.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 10-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import Foundation

struct User: Codable {
    // Naam etc van de gebruiker.
    var name: String
    var email: String
    var password: String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("UserData").appendingPathExtension("plist")
    
    // Laat de data uit geheugen.
    static func loadUserData() -> [User]? {
        guard let userData = try? Data(contentsOf: ArchiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<User>.self, from: userData)
    }
    
    // Sla de data op in geheugen.
    static func saveUserData(_ user: [User]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedUserData = try? propertyListEncoder.encode(user)
        try? codedUserData?.write(to: ArchiveURL, options: .noFileProtection)
    }
}

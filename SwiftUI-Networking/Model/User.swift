//
//  User.swift
//  SwiftUI-Networking
//
//  Created by Luko on 19/01/2021.
//

import Foundation

struct User: Codable, Hashable {
    
    var firstName:String
    var needs: Needs
    
    struct Needs: Codable, Hashable {
        var medicalHelp: Bool
        var otherHelp: Bool
    }
}

//
//  Source.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 27/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

struct Source: Codable {
    var id: String
    var name: String
    var description: String
    var url: URL
    var category: String
    var language: String
    var country: String
}


struct SourcesList: Codable {
    var sources: [Source]
}

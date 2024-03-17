//
//  User.swift
//  KsyCare
//
//  Created by Артём Шаповалов on 17.03.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let login: String
    let role: String
}

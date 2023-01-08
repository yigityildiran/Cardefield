//
//  Protocols.swift
//  Caishen
//
//  Created by Caishen on 19/12/2022.
//

import Foundation

protocol DataServiceProtocol {
    func getData() async throws -> [Category]
}

//
//  Protocol.swift
//  Caishen
//
//  Created by Caishen on 20/12/2022.
//

import Foundation
protocol DataServiceProtocol {
    func getData() async throws -> [Category]
}

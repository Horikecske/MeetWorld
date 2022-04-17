//
//  UpdateResponse.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 14..
//

import Foundation

// model of the response received after the post request
struct UpdateResponse: Codable {
    let result: String
    let status: String
}

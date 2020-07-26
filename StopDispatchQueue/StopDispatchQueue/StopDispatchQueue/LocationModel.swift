//
//  LocationModel.swift
//  StopDispatchQueue
//
//  Created by Boss on 7/26/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import Foundation

struct area: Codable {
    

    var code: String?
    var name: String?
}

struct LocationModel: Codable {
    var latitude: Double?
    var longitude: Double?
}

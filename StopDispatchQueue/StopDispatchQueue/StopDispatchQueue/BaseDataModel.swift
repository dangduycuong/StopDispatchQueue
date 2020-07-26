//
//  BaseDataModel.swift
//  StopDispatchQueue
//
//  Created by Boss on 7/26/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import Foundation

struct DataTotal: Codable {
    var properties: BaseDataModel?
}

struct BaseDataModel: Codable {
    var area: area?
    var location: LocationModel?
}

//
//  StationResponseModel.swift
//  SubWay
//
//  Created by 목정아 on 2023/07/07.
//

import Foundation

struct StationResponseModel : Decodable {
    
    var stations: [Station] { searchInfo.row }
    
    private let searchInfo: SearchInfoBySubwayNameServiceName
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceName: Decodable {
        var row : [Station]
    }
}

struct Station: Decodable {
    let stationName : String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}


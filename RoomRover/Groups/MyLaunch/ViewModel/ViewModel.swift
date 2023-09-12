//
//  ViewModel.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 11.09.23.
//

import Foundation

struct HotelData: Decodable {
    
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel

    struct AboutTheHotel: Decodable {
        let description: String
        let peculiarities: [String]
    }
}


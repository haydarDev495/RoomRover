//
//  GetRequests.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 13.09.23.
//

import Foundation


class GetRequests {
        
    // -
    static let shared = GetRequests()
    
    func getHotelData(completion: @escaping (_ hotelModel: HotelData?) -> ()) {
        guard let url = URL(string: AppConstant.hotelUrl) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let hotelModel = try decoder.decode(HotelData.self, from: data)
                completion(hotelModel)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
    
    func getRoomData(completion: @escaping (_ roomModel: RoomViewModel?) -> Void ) {
        guard let url = URL(string: AppConstant.roomUrl) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let roomModel = try decoder.decode(RoomViewModel.self, from: data)
                completion(roomModel)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
    
    func getBookingData(completion: @escaping (_ bookingModel: BookingModel?) -> Void ) {
        guard let url = URL(string: AppConstant.bookingUrl) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let roomModel = try decoder.decode(BookingModel.self, from: data)
                DispatchQueue.main.async {
                    completion(roomModel)
                }
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
}

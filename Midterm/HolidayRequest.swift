//
//  HolidayRequest.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/16/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
    
}
struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "a72b0578557c0da4dfb74e7e460d74f39a307691"
    
    init(countryCode:String){
     let date = Date()
     let format = DateFormatter()
     format.dateFormat = "2020"
     let currentYear = format.string(from: date)
        
    let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getHolidays (completion: @escaping(Result<[HolidayDetails], HolidayError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}

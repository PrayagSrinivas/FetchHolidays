//
//  HolidayRequest.swift
//  HolidayDetails
//
//  Created by Jovial Software on 10/11/20.
//

import Foundation
enum HolidayError:Error{
    case noDataAvailable
    case canNotProcessData
}
struct HolidayRequest{
    let resourceURL:URL
    let API_KEY = "3bd503157cf068262970473419402a114ea9451e"
    init(countryCode:String){
        let date = Date()
        let format  = DateFormatter()
        format.dateFormat = "yyy"
        let currentYear = format.string(from: date)
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString)  else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }
    func getHolidays(completion: @escaping(Result<[HolidayDetail],HolidayError>)->Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data,_,_) in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            }
            catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
  
}

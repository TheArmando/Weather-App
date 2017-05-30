//
//  DarkSkyService.swift
//  Weather App
//
//  Created by Armando Silveira on 5/30/17.
//  Copyright © 2017 Armando Silveira. All rights reserved.
//

import Foundation
import Alamofire


public class DarkSkyService {
    
    private static let baseURL = "https://api.darksky.net/forecast/"
    private static let apiKey = "cab5ebd1303d971ffa7903172f9c0aa9"
    
    
    
    static func weatherForCoordinates(latitude: String, longitude: String, completion: @escaping (WeatherData?, Error?) -> ()) {
        
        let url = baseURL + apiKey + "/\(latitude),\(longitude)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let result):
                completion(WeatherData(data: result), nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    



}





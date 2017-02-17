//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Sierra 4 on 14/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class WeatherResponse: Mappable {
    var Headline : Headline?
    var DailyForecasts : [DailyForecasts]?
    
    required init?(map: Map){
        Headline <- map["Headline"]
        DailyForecasts <- map["DailyForecasts"]
    }
    
    func mapping(map: Map) {
        Headline <- map["Headline"]
        DailyForecasts <- map["DailyForecasts"]
    }
}


class Headline: Mappable {
    var EffectiveEpochDate : String?
    var Severity : Int?
    var Category : String?
    
    required init?(map: Map){
        EffectiveEpochDate <- map["EffectiveEpochDate"]
        Severity <- map["Severity"]
        Category <- map["Category"]
    }
    
    func mapping(map: Map) {
        EffectiveEpochDate <- map["EffectiveEpochDate"]
        Severity <- map["Severity"]
        Category <- map["Category"]
    }
}

class DailyForecasts: Mappable {
    var Date : String?
    var Temperature : Temperature?
  
    required init?(map: Map){
        Date <- map["Date"]
        Temperature <- map["Temperature"]
    }
    
    func mapping(map: Map) {
        Date <- map["Date"]
        Temperature <- map["Temperature"]
    }
}

class Temperature: Mappable {
    var Minimum : Minimum?
    var Maximum : Maximum?
  
    required init?(map: Map){
        Minimum <- map["Minimum"]
        Maximum <- map["Maximum"]
    }
    
    func mapping(map: Map) {
        Minimum <- map["Minimum"]
        Maximum <- map["Maximum"]
    }
}

class Minimum : Mappable {
    var Value : Int?
    
    required init?(map: Map){
    Value <- map["Value"]
    }
    
    func mapping(map: Map) {
        Value <- map["Value"]
    }
}

class Maximum : Mappable {
    var Value : Int?
    
    required init?(map: Map){
    Value <- map["Value"]
    }
    
    func mapping(map: Map) {
    Value <- map["Value"]
    }
}


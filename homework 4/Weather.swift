//
//  Weather.swift
//  homework 4
//
//  Created by Ярослав on 15.02.2023.
//

import Foundation

func convertFromTimestampToDate(time:Int) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    
    let nsDate = NSDate(timeIntervalSince1970: TimeInterval(time))
    let stringDate = dateFormatter.string(from: nsDate as Date)
    return dateFormatter.date(from: stringDate)!
}

func convertFromKelvinToCelsius(temp: Float) -> Float {
    return temp - 273.15
}
struct Json: Decodable {
    let lat, lon: Float
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]
    let hourly: [Hourly]
    let daily: [Daily]
    let alerts: [Alerts]
}

struct Current: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dt = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .dt))
        self.sunrise = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .sunrise))
        self.sunset = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .sunset))
        
        self.temp = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .temp))
        self.feelsLike = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .feelsLike))
        self.dewPoint = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .dewPoint))

        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.uvi = try container.decode(Float.self, forKey: .uvi)
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        self.windSpeed = try container.decode(Int.self, forKey: .windSpeed)
        self.windDeg = try container.decode(Int.self, forKey: .windDeg)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.rain = try container.decode(Rain.self, forKey: .rain)
    }
    
    let dt, sunrise, sunset: Date
    let temp, feelsLike: Float
    let pressure, humidity: Int
    let dewPoint, uvi: Float
    let clouds, visibility, windSpeed, windDeg: Int
    let weather: [Weather]
    let rain: Rain
    
    enum CodingKeys: CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case feelsLike
        case pressure
        case humidity
        case dewPoint
        case uvi
        case clouds
        case visibility
        case windSpeed
        case windDeg
        case weather
        case rain
    }
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct Rain: Decodable {
    let h: Float
    enum CodingKeys: String, CodingKey {
        case h = "1h"
    }
}

struct Minutely: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dt = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .dt))
        
        self.precipitation = try container.decode(Float.self, forKey: .precipitation)
    }
    
    let dt: Date
    let precipitation: Float
    
    enum CodingKeys: CodingKey {
        case dt
        case precipitation
    }
}

struct Hourly: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dt = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .dt))
        
        self.temp = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .temp))
        self.feelsLike = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .feelsLike))
        self.dewPoint = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .dewPoint))
        
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.uvi = try container.decode(Float.self, forKey: .uvi)
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        self.windSpeed = try container.decode(Float.self, forKey: .windSpeed)
        self.windDeg = try container.decode(Int.self, forKey: .windDeg)
        self.windGust = try container.decode(Float.self, forKey: .windGust)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.pop = try container.decode(Int.self, forKey: .pop)
    }
    let dt: Date
    let temp, feelsLike: Float
    let pressure, humidity: Int
    let dewPoint, uvi: Float
    let clouds, visibility: Int
    let windSpeed: Float
    let windDeg: Int
    let windGust: Float
    let weather: [Weather]
    let pop: Int
    
    enum CodingKeys: CodingKey {
        case dt
        case temp
        case feelsLike
        case pressure
        case humidity
        case dewPoint
        case uvi
        case clouds
        case visibility
        case windSpeed
        case windDeg
        case windGust
        case weather
        case pop
    }
}

struct Daily: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dt = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .dt))
        self.sunrise = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .sunrise))
        self.sunset = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .sunset))
        self.moonrise = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .moonrise))
        self.moonset = convertFromTimestampToDate(time:try container.decode(Int.self, forKey: .moonset))
        
        self.dewPoint = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .dewPoint))
        
        self.moonPhase = try container.decode(Float.self, forKey: .moonPhase)
        self.temp = try container.decode(Temp.self, forKey: .temp)
        self.feelsLike = try container.decode(FeelsLike.self, forKey: .feelsLike)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.windSpeed = try container.decode(Float.self, forKey: .windSpeed)
        self.windDeg = try container.decode(Int.self, forKey: .windDeg)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.pop = try container.decode(Float.self, forKey: .pop)
        self.rain = try container.decode(Float.self, forKey: .rain)
        self.uvi = try container.decode(Float.self, forKey: .uvi)
    }
    
    let dt, sunrise, sunset : Date
    let moonrise, moonset: Date
    let moonPhase: Float
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint: Float
    let windSpeed: Float
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let pop, rain, uvi: Float
    
    enum CodingKeys: CodingKey {
        case dt
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase
        case temp
        case feelsLike
        case pressure
        case humidity
        case dewPoint
        case windSpeed
        case windDeg
        case weather
        case clouds
        case pop
        case rain
        case uvi
    }
}

struct Temp: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .day))
        self.min = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .min))
        self.max = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .max))
        self.night = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .night))
        self.eve = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .eve))
        self.morn = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .morn))
    }
    let day, min, max, night, eve, morn: Float
    
    enum CodingKeys: CodingKey {
        case day
        case min
        case max
        case night
        case eve
        case morn
    }
}

struct FeelsLike: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .day))
        self.night = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .night))
        self.eve = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .eve))
        self.morn = convertFromKelvinToCelsius(temp: try container.decode(Float.self, forKey: .morn))
    }
    let day, night, eve, morn: Float
    enum CodingKeys: CodingKey {
        case day
        case night
        case eve
        case morn
    }
}

struct Alerts: Decodable {
    let senderName, event: String
    let start, end: Int
    let description: String
    let tags: [String]
}

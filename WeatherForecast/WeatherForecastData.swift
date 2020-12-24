//
//  WeatherForecastData.swift
//  WeatherForecast
//
//  Created by 羅壽之 on 2020/12/4.
//

import Foundation

struct WeatherForecastData: Codable {
    var name: String
    var coord: Coord
    var main: Main
    var weather: [Weather]
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
}

struct Main: Codable {
    var temp: Double
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Codable {
    var main: String
    var description: String
    var icon: String
}

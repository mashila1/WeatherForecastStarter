//
//  CityWeatherController.swift
//  WeatherForecast
//
//  Created by 羅壽之 on 2020/12/22.
//

import UIKit

class CityWeatherController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var cities = [
    (eName:"Kaohsiung",cName:"高雄市"),
   // (eName:"New Taipei",cName:"新北市"),
    (eName:"Taichung",cName:"臺中市"),
    (eName:"Tainan",cName:"臺南市"),
    (eName:"Taipei",cName:"臺北市"),
    (eName:"Taoyuan",cName:"桃園市"),
    (eName:"Chiayi",cName:"嘉義市"),
    (eName:"Hsinchu",cName:"新竹市"),
    (eName:"Keelung",cName:"基隆市"),
    (eName:"Changhua",cName:"彰化市"),
    (eName:"Douliu",cName:"斗六市"),
    (eName:"Hualien",cName:"花蓮市"),
    (eName:"Magong",cName:"馬公市"),
    (eName:"Miaoli",cName:"苗栗市"),
    (eName:"Nantou",cName:"南投市"),
    (eName:"Pingtung",cName:"屏東市"),
    (eName:"Puzi",cName:"朴子市"),
    (eName:"Taibao",cName:"太保市"),
    (eName:"Taitung",cName:"臺東市"),
    (eName:"Toufen",cName:"頭份市"),
    (eName:"Yilan",cName:"宜蘭市"),
    (eName:"Yuanlin",cName:"員林市"),
    (eName:"Zhubei",cName:"竹北市")
    ]
    
    private let API_URL = "https://api.openweathermap.org/data/2.5/weather?"
    private let ICON_URL = "https://openweathermap.org/img/wn/"
    private let API_KEY = "YOUR_KEY"
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherState: UILabel!
    @IBOutlet var weatherIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = cities[indexPath.row].cName
        cell.detailTextLabel?.text = cities[indexPath.row].eName
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getForecast(location: cities[indexPath.row].eName)
    }
    
    func getForecast(location: String) {
        
        guard let accessURL = URL(string: API_URL + "q=\(location)&units=metric&lang=zh_tw&appid=\(API_KEY)") else {
            return
        }
        
        let request = URLRequest(url: accessURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            //parse data
            if let data = data {
                let decoder = JSONDecoder()
                if let weatherData = try? decoder.decode(WeatherForecastData.self, from: data) {
                    //download weahter icon
                    self.getImage(weatherCode: weatherData.weather[0].icon)
                    OperationQueue.main.addOperation {
                        self.cityName.text = weatherData.name
                        self.weatherState.text = weatherData.weather[0].description
                    }
                }
            }
        })
        
        task.resume()
    }
    
    
    func getImage(weatherCode: String) {
        
        guard let accessURL = URL(string: ICON_URL + "\(weatherCode)@2x.png") else {
            return
        }
        
        let request = URLRequest(url: accessURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            //parse data
            if let data = data, let image = UIImage(data: data) {
                OperationQueue.main.addOperation {
                    self.weatherIcon.image = image
                }
            }
        })
        
        task.resume()
    }
    
     
}

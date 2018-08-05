//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Halil Özel on 4.08.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var cityName = ""
    var currentWeather = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // içerik kadar cell oluşturma
        tableView.tableFooterView = UIView()
        
        getTodayResult()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
            cell.selectedText?.text = "Seçtiğiniz şehir :  \(cityName)"
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondTableViewCell
            
            cell.resultText.text = currentWeather
            
            return cell
        }
        
        
    }
    
    func getTodayResult(){
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0f6112b1d663b03202ffabe9788c51ef"){
        
         let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil{
                
                if let incommingData = data{
                    
                    do{
                        let jsonResult =  try JSONSerialization.jsonObject(with: incommingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                      //  print(jsonResult)
                        
                        
                        //let weather = jsonResult["weather"] as! NSArray
                        
                        //let weather1 = weather.firstObject as! [String : AnyObject]
                        
                        
                         if let main = jsonResult["main"] as? NSDictionary{
                            // print("Seçtiğin şehrin hava durum bilgisi : \(description)")
                            
                            if let temp = main["temp"] as? Double{
                                
                                var state = (Int)(temp - 273.15)
                            
                            //print(description)
                            
                           
                            DispatchQueue.main.sync(execute: {
                                self.currentWeather = String (state)
                                self.tableView.reloadData()
                            })
                            }
                        }
                        
                    //    let degrees = jsonResult["main"] as! NSObject
                        
                      //  let degress1 = degrees.value(forKey: "temp") as! ["String" : Double]
                        
                       /* if let desc = degress1["temp"] as? Double{
                            print("\(desc)")
                            
                         
                        }*/
                        
                    
                        
                        
                    }catch{
                        print("Hata oluştu")
                    }

                    
                    
                }
            }
            
        
        }
            task.resume()
        }
        
        
        
    }

}

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
    
    var refreshAction = UIRefreshControl() // yenileme nesnesi tanımlandı.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // içerik kadar cell oluşturma
        tableView.tableFooterView = UIView()
        
        getTodayResult()
        
        // yenileme işlemleri için gerekli ayarlamalar
        refreshAction.addTarget(self, action: #selector(refreshNow), for: UIControl.Event.valueChanged)
        
        // renk ayarı
        refreshAction.tintColor = UIColor.red
        
        // tableView'e ekleme
        self.tableView.addSubview(refreshAction)
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
            cell.selectedText?.text = "Selected City :  \(cityName)"
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondTableViewCell
            
            cell.resultText.text = currentWeather
            
            return cell
        }
        
        
    }
    
    // yenilenince neler olacak onun bilgilerinin bulunduğu alandır.
    @objc func refreshNow(){
        
        
        // ismini güncelle
        cityName = "istanbul"
        
        // yenilemeyi bitir
        self.refreshAction.endRefreshing()
        
        // metodu cağır
        getTodayResult()
    }
    
    func getTodayResult(){
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0f6112b1d663b03202ffabe9788c51ef"){
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error == nil{
                    
                    if let incommingData = data{
                        
                        do{
                            let jsonResult =  try JSONSerialization.jsonObject(with: incommingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                            
                            if let main = jsonResult["main"] as? NSDictionary{
                            
                                
                                if let temp = main["temp"] as? Double{
                                    
                                    let state = (Int)(temp - 273.15)
                    
                                    DispatchQueue.main.sync(execute: {
                                        self.currentWeather = String (state)
                                        self.tableView.reloadData()
                                    })
                                }
                            }
                    
                            
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

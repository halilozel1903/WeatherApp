//
//  ViewController.swift
//  WeatherApp
//
//  Created by Halil Özel on 4.08.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var showButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // buttonun köşelerine sekil verme işlemleri
        showButton.layer.cornerRadius = 6
        showButton.layer.masksToBounds = true
    }
    
    
    @IBAction func weatherClicked(_ sender: Any) {
        
        if cityName.text == ""{
            
            let alert = UIAlertController(title: "Hata Mesajı", message: "Lütfen şehir adını boş bırakmayınız.", preferredStyle: .alert)
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(cancelButton)
            
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeatherStoryboardID") as! WeatherTableViewController
            
            vc.cityName = (self.cityName?.text)!
            
            self.show(vc, sender: nil)
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}


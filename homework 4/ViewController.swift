//
//  ViewController.swift
//  homework 4
//
//  Created by Ярослав on 15.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "valid", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let json = try! decoder.decode(Json.self, from: data)
        print(json.current.dt)
        print(json.current.feelsLike)
        print(json.minutely[0].dt)
        print(json.hourly[0].dewPoint)
        print(json.daily[0].feelsLike.eve)
    }


}

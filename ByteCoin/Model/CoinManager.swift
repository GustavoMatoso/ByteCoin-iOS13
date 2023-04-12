//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didFailWithError(error: Error)
    func updateBTCValue(value: CoinModel)
}



struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "BB05BE43-F373-412F-8E71-A981ECC8EC55"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getURL(currency: String){
    
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String){
        
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                delegate?.didFailWithError(error: error!)
            }
            if let safeData = data{
                if let btc = parseJSON(safeData){
                        //delegate?.didUpdateWeather(self,weather: weather)
                    delegate?.updateBTCValue(value: btc)
                }
            }
        }
        task.resume()
            
    }
    
    func parseJSON(_ coinData: Data)-> CoinModel?{
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let chosenCurrency = decodedData.asset_id_quote
            let btcValue = decodedData.rate
            
            let btc = CoinModel(chosenCurrency: chosenCurrency, btcValue: btcValue)
            return btc
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
    }
    
}

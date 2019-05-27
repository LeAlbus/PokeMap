//
//  APIManager.swift
//  PokeMap
//
//  Created by Pedro Lopes on 05/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let sharedInstance = APIManager()

    var isGettingData = false
    
    func requestRepoList
        (resultPage: Int = 1, resultHandler: @escaping (_ successObject: [Pokemon]) -> ()){
        
        self.isGettingData = true
        
        Alamofire.request("\(BaseAPIUrl)\(PokemonMaxNumber)").responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let data = response.data
                    let responseList = try JSONDecoder().decode(PokemonList.self, from: data!)
                    
                    let pokeList = responseList.results
                    
                    resultHandler(pokeList)
                    self.isGettingData = false
                    
                    
                } catch let error{
                    print ("Error while parsing response")
                    print (error)
                    self.isGettingData = false
                    
                }
            case .failure(_):
                print ("Could not retrieve information from url")
                resultHandler([])
                self.isGettingData = false
                
            }
        }
    }

    func getPokeInfo(searchStr: String = "", searchNmbr: Int = -1, resultHandler: @escaping (_ successObject: PokeInfo) -> (), errorHandler: @escaping (_ requestSuccess: Bool) -> ()) {
       
        var searchValue: String = searchStr
        if searchValue == "" {
             searchValue = String(searchNmbr)
        }
        
        if searchValue != "" && searchValue != "-1" {
            Alamofire.request("\(SearchAPIUrl)pokemon/\(searchValue)").responseJSON { response in
                switch response.result {
                case .success:
                    do{
                        let data = response.data
                        let responseParsed = try JSONDecoder().decode(PokeInfo.self, from: data!)
                        
                        resultHandler(responseParsed)
                        self.isGettingData = false
                        
                    } catch let error{
                        print ("Error while parsing response")
                        print (error)
                        errorHandler(true)
                        self.isGettingData = false
                        
                    }
                case .failure(_):
                    print ("Could not retrieve information from url")
                    errorHandler(false)
                    self.isGettingData = false
                    
                }
            }
        }
    }
}

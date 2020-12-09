//
//  Observer.swift
//  SwiftUI-Networking
//
//  Created by Luko on 13/11/2020.
//

import Combine
import Alamofire
import SwiftyJSON

// The View-Model
class Observer : ObservableObject {

    @Published var organizations = [Organization]()
  
    init() {
        
        /* Networking 🚀 **************/
        // Alamofire appears here
        AF.request("https://api.github.com/users/hadley/orgs", method: .get)
            .validate()
            .responseData { response in
            
            switch response.result {
            
                // Success! 😀
                case .success(let rawData):
                    
                    print("RECEIVED VALUE: \(rawData)")
                    
                    // SwiftyJSON appears here
                    let jsonResponse = JSON(rawData)
                    
                    print(jsonResponse)
                    
                    // Itera el array de JSONs recibido
                    // Extrae los valores buscados
                    // Los almacena en una colección de instancias de la estructura "Organization" (Model)
                    for item in jsonResponse {
                        self.organizations.append(Organization(
                                                    id: item.1["id"].intValue,
                                                    name: item.1["login"].stringValue,
                                                    avatarUrl: item.1["avatar_url"].stringValue,
                                                    reposUrl: item.1["repos_url"].stringValue))
                    }

                // Failure 😦
                case .failure(let error):
                    print(error)
            }
                
                // DEBUG
                print(self.organizations)
        }
    }
}

//
//  Observer.swift
//  SwiftUI-Networking
//
//  Created by Luko on 13/11/2020.
//

import Combine
import Alamofire
import SwiftyJSON
import Foundation

// The View-Model
class Observer : ObservableObject {

    @Published var organisations = [Organisation]()
    
    @Published var users = [User]()
  
    init() {
        
        /* Networking 🚀 **************/
        // Alamofire appears here
        AF.request("https://fightpandemics.com/api/users/", method: .get)
            
            // Validation
            .validate()
            
            // URL Description
            .cURLDescription { description in
                print("cURLDescription", description)
            }
            // Metrics
            .responseJSON { response in
                debugPrint("METRICS", response.metrics ?? "")
            }
            
            // Response Data
            .responseData { response in
            
            switch response.result {
            
                // Success! 😀
                case .success(let rawData):
                    
                    print("RECEIVED VALUE: \(rawData)")
                    
                    // SwiftyJSON appears here
                    let jsonResponse = JSON(rawData)

                    print("json response", jsonResponse)

                    for item in jsonResponse {
                        
                        self.users.append(User(firstName: item.1["firstName"].stringValue)

                        )
                    }

                // Failure 😦
                case .failure(let error):
                    print(error)
            }
                
                // DEBUG
                print("SWIFT STRUCT ORGANISATION POPULATED ➡️ ", self.users)
        }
    }
}

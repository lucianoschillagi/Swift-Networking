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

            // Response Data
            .responseData { [self] response in
            
            switch response.result {
            
                // Success! 😀
                case .success(let rawData):
                    
                    print("RECEIVED VALUE: \(rawData)")
                    
                    let users = try! JSONDecoder().decode([User].self, from: rawData)
                    
                    print("Response: \(users)")
                    
                    for user in users {
                        print(user.firstName)
                        print("Medical Help?", user.needs.medicalHelp)
                        print("Other Help?", user.needs.otherHelp)
                        self.users.append(user)
                    }
                    
                    print("FIRST USER NAME", self.users[0].firstName)


                // Failure 😦
                case .failure(let error):
                    print(error)
            }
                
                // DEBUG
                print("SWIFT STRUCT USER POPULATED ➡️ ", self.users)
        }
    }
}

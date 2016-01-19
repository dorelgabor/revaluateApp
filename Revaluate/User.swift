//
//  User.swift
//  Revaluate
//
//  Created by Dorel Gabor on 19/01/16.
//  Copyright © 2016 REVALUATE. All rights reserved.
//

import Foundation

class User {
    
    func loginUser(email: NSString, password: NSString) -> NSDictionary {
        let httpCommandExecutor = HttpCommandExecutor()
        
        return httpCommandExecutor.accountLogin(email, password: password)
    }
}
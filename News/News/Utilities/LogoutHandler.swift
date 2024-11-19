//
//  LogoutHandler.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

class LogoutHandler {
    
    //Clear everything when logout
    class func logout() {
        _ = KeychainViewModel().removeAllData()
    }
    
}

//
//  String.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

struct Strings {
    
    struct TabNavigation {
        static let search = "Search"
        static let favorites = "Favorites"
        static let settings = "Settings"
    }
    
    struct AlertMessage {
        static let searchMinimumLimit = "Search text must be at leasr 3 charcaters long."
        static let warning = "Warning"
        static let error = "Error"
        static let somethingWrong = "Something went wrong..!"
        static let success = "Success"
        static let logout = "Are you sure logout?"
        static let emptyOldKey = "Please enter the old API Key"
        static let notFoundOldKey = "API Key not found"
        static let notFoundKey = "Old API Key not found"
        static let inValidOldKey = "Please enter valid old API Key"
        static let emptyNewKey = "Please enter the new API Key"
        static let keyUpdateSucessfully = "API Key updated successfully"
        static let emptyKey = "Please enter the API Key"
        static let removedFromFavourite = "Article Removed From Favourite"
        static let addedInFavourite = "Article Added In Favourite"
    }
    
    struct dateFrormatter {
        static let yyyyMMdd = "yyyy-MM-dd"
    }
    
    struct userDefault {
        static let favoriteCount = "favoriteCount"
    }
    
    static let cancel = "Cancel"
    static let ok = "Ok"
}

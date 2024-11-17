//
//  UIImageView.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    enum ImageLoadError: Error {
        case invalidURL
    }
    
    func setImage(uri: String?, placeholder: UIImage? = nil, completion: ((UIImage?, Error?) -> Void)? = nil) {
        if let uri = uri?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: uri) {
            sd_setImage(with: url, placeholderImage: placeholder, options: []) { (image, error, _, _) in
                completion?(image, error)
            }
        } else {
            if let validCompletionBlock = completion {
                validCompletionBlock(nil, ImageLoadError.invalidURL)
            } else {
                image = placeholder
            }
        }
    }
    
}

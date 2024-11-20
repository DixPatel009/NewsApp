//
//  CollectionHeaderView.swift
//  News
//
//  Created by Akabari Dixit on 20/11/24.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var searchTextLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    static let identifier = String(describing: CollectionHeaderView.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

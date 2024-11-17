//
//  NewsCollectionViewCell.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    // MARK: - Properties
    
    static let identifier = String(describing: NewsCollectionViewCell.self)
    private let placeHolderImage = UIImage(named: Images.Placeholders.newsFallBack)
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    private func setUpView() {
        self.cardView.roundCorners()
        self.imageVIew.roundCorners()
        self.imageVIew.image = nil
    }
    
    func populate(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        imageVIew.setImage(uri: article.urlToImage, placeholder: placeHolderImage, completion: nil)
    }

}

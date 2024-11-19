//
//  NewsTableViewCell.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    // MARK: - Properties
    static let identifier = String(describing: NewsTableViewCell.self)
    private let placeHolderImage = UIImage(named: Images.Placeholders.newsFallBack)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpView() {
        self.cardView.roundCorners()
        self.imageVIew.image = nil
    }
    
    func populate(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        imageVIew.setImage(uri: article.urlToImage, placeholder: placeHolderImage, completion: nil)
    }
    
}

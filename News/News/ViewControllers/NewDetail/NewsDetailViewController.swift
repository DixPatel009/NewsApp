//
//  NewsDetailViewController.swift
//  News
//
//  Created by Akabari Dixit on 18/11/24.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    // MARK: - Properties
    
    var articleModel: Article?
    
    // MARK: - View LifeCycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(article: Article) {
        self.articleModel = article
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }

}

// MARK: - Setup

extension NewsDetailViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
        self.navigationBarView.backgroundColor = UI.Colors.backGroundColor
        navigationController?.navigationBar.setTransparent()
        self.setCustomBackButton()
        self.setUpArticaleData()
    }
    
    private func setUpArticaleData() {
        
        if let model = self.articleModel {
            self.imageView.setImage(uri: model.urlToImage, placeholder: UIImage(named: Images.Placeholders.newsFallBack), completion: nil)
            self.titleLabel.text = model.title
            self.descriptionLabel.text = model.description
            self.contentLabel.text = model.content
            self.favouriteButton.tintColor = .lightGray
        }
    }

}

// MARK: - Scroll View Delegate

extension NewsDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let start = imageView.frame.size.height - 84
        if offset < start {
            self.navigationBarView.alpha = 0
        } else {
            self.navigationBarView.alpha = 1
        }
        navigationController?.navigationBar.setNeedsLayout()
    }
    
}

// MARK: - IBAction

extension NewsDetailViewController {
    
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        
    }
    
}

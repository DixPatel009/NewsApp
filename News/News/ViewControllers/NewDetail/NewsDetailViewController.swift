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
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: - Properties
    
    var articleModel: Article?
    private let viewModel = ArticleViewModel()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpArticaleData()
    }
    
}

// MARK: - Setup

extension NewsDetailViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
        self.navigationBarView.backgroundColor = UI.Colors.backGroundColor
        navigationController?.navigationBar.setTransparent()
        self.openButton.roundCorners()
        self.shareButton.roundCorners()
        self.setCustomBackButton()
    }
    
    private func setUpArticaleData() {
        
        if let model = self.articleModel {
            self.imageView.setImage(uri: model.urlToImage, placeholder: UIImage(named: Images.Placeholders.newsFallBack), completion: nil)
            self.titleLabel.text = model.title
            self.descriptionLabel.text = model.description
            self.contentLabel.text = model.content
            self.openButton.isHidden = (model.url == "")
            self.setFavouriteButton()
        }
    }
    
    private func setFavouriteButton() {
        if let model = self.articleModel {
            self.favouriteButton.tintColor = viewModel.isArticleInFavorites(model) ? UI.Colors.coreBlue : .lightGray
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
        guard let article = self.articleModel else {
            return
        }
        if viewModel.isArticleInFavorites(article) {
            viewModel.removeArticleFromFavorites(article)
            self.view.makeToast(Strings.AlertMessage.removedFromFavourite)
        } else {
            viewModel.saveArticleToFavorites(article)
            self.view.makeToast(Strings.AlertMessage.addedInFavourite)
        }
        self.setFavouriteButton()
    }
    
    @IBAction func openButtonAction(_ sender: UIButton) {
        guard let article = self.articleModel,
              let url = URL(string: article.url) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        guard let article = self.articleModel else {
            return
        }
        let shareText = article.title + "\n\n" + article.url
        self.presentActivityViewController(shareable: shareText)
    }
    
}

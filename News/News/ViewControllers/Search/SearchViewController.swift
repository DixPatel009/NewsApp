//
//  SearchViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    private var viewModel = NewsViewModel()
    private let activityIndicator = ActivityIndicator()
    private let cellIdentifiers = NewsCollectionViewCell.identifier
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        self.setupViewModel()
    }
    
}

// MARK: - Setup

extension SearchViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.collectionViewLayout = createSingleColumnLayout()
        self.collectionView.register(UINib(nibName: cellIdentifiers, bundle: nil), forCellWithReuseIdentifier: cellIdentifiers)
    }
    
    private func createSingleColumnLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 0.0)
        return layout
    }
    
    private func createGridLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (view.frame.width - 8) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)
        return layout
    }
    
    private func toggleLoader(isShow: Bool) {
        hideSubviews(isShow)
        if (isShow) {
            activityIndicator.display(in: view)
        } else {
            activityIndicator.dismiss()
        }
    }
    
    private func hideSubviews(_ shouldHide: Bool) {
        let alpha: CGFloat = shouldHide ? 0 : 1
        view.subviews.forEach { $0.alpha = alpha }
    }
    
    private func setupViewModel() {
        
        viewModel.onNewsFetched = { [weak self] in
            guard let self = self else { return }
            print("Data Fetched reload tableview")
            self.toggleLoader(isShow: false)
            self.collectionView.reloadData()
        }
        
        viewModel.onError = { [weak self] error in
            guard let self = self else { return }
            AlertHelper.showAlert(on: self, title: "Error", message: error.description)
            self.toggleLoader(isShow: false)
        }
        
        self.toggleLoader(isShow: true)
        viewModel.fetchNews(query: "apple", reset: true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers, for: indexPath) as! NewsCollectionViewCell
        let article = viewModel.article(at: indexPath.row)
        cell.populate(with: article)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let article = viewModel.article(at: indexPath.row)
        let width = collectionView.frame.width
        
        let calculatedWidth = width - 176
        let titleHeight = article.title.height(withConstrainedWidth: calculatedWidth, font: .boldSystemFont(ofSize: 16))
        let descriptionHeight = article.description?.height(withConstrainedWidth: calculatedWidth, font: .systemFont(ofSize: 14)) ?? 0.0
        
        var totalHeight = titleHeight + descriptionHeight
        if totalHeight < 120 {
            totalHeight = 120.0
        }
        
        return CGSize(width: width, height: totalHeight + 48.0)
    }
    
}

// MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText.count >= 2 else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.searchMinimumLimit)
            return
        }
        
        viewModel.fetchNews(query: searchText, reset: true)
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight * 2 {
            if let searchText = searchBar.text, searchText.count >= 2 {
                viewModel.fetchNews(query: searchText)
            } else {
                viewModel.fetchNews(query: "apple")
            }
            
        }
    }
    
}

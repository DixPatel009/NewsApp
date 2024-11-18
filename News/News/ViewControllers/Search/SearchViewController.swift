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
    @IBOutlet weak var fromDateButton: UIButton!
    @IBOutlet weak var noDataView: UIView!
    
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
        self.fromDateButton.roundCorners()
        if let monthAgoDate = GlobalFunction.shared.oneMonthAgo() {
            self.fromDateButton.setTitle(monthAgoDate.stringFromDate(), for: .normal)
        }
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
        if (isShow) {
            self.collectionView.alpha = 0
            self.noDataView.isHidden = true
            activityIndicator.display(in: view)
        } else {
            activityIndicator.dismiss()
            self.collectionView.alpha = 1
        }
    }
    
    private func setupViewModel() {
        
        viewModel.onNewsFetched = { [weak self] in
            guard let self = self else { return }
            print("Data Fetched reload tableview")
            self.showNoDataView()
        }
        
        viewModel.onError = { [weak self] error in
            guard let self = self else { return }
            AlertHelper.showAlert(on: self, title: "Error", message: error.description)
            self.showNoDataView()
        }
        
        self.toggleLoader(isShow: true)
        self.callFetchNewsAPI(reset: true)
    }
    
    private func showNoDataView() {
        self.collectionView.reloadData()
        self.noDataView.isHidden = viewModel.articles.count > 0
        self.toggleLoader(isShow: false)
    }
    
    private func callFetchNewsAPI(reset: Bool = false) {
        var query: String = "apple"
        if let searchText = searchBar.text,
           searchText.count >= 2 {
            query = searchText
        }
        
        viewModel.fetchNews(query: query, fromDate: self.getSelectedDateInString(), reset: reset)
    }
    
    private func getSelectedDateInString() -> String? {
        if let date = self.fromDateButton.titleLabel?.text,
           date != "From Date"  {
            return date
        }
        return nil
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

// MARK: - IBAction

extension SearchViewController {
    
    @IBAction func fromDateButtonAction(_ sender: UIButton) {
        DatePickerManager.shared.showDatePicker(in: self, selectedDate: self.fromDateButton.titleLabel?.text) { [weak self] selectedDate in
            guard let self = self else { return }
            self.fromDateButton.setTitle(selectedDate, for: .normal)
            self.toggleLoader(isShow: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                self.callFetchNewsAPI(reset: true)
            }
        }
    }
    
}

// MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                self.toggleLoader(isShow: true)
                self.callFetchNewsAPI(reset: true)
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              searchText.count >= 2 else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.searchMinimumLimit)
            return
        }
        
        self.toggleLoader(isShow: true)
        self.callFetchNewsAPI(reset: true)
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight * 2 {
            self.callFetchNewsAPI()
        }
    }
    
}

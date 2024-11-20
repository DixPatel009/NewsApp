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
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var layoutChangeButton: UIButton!
    
    // MARK: - Properties
    
    private var viewModel = NewsViewModel()
    private let articalViewModel = ArticleViewModel()
    private var isGridLayout: Bool = false
    private let activityIndicator = ActivityIndicator()
    private let cellIdentifiers = NewsCollectionViewCell.identifier
    private let gridCellIdentifiers = "NewsGridCollectionViewCell"
    private let headerIdentifiers = CollectionHeaderView.identifier
    private var swipableExtension: CollectionSwipableCellExtension?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

// MARK: - Setup

extension SearchViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
        self.layoutChangeButton.roundCorners()
        self.fromDateButton.roundCorners()
        self.filterButton.roundCorners()
        if let monthAgoDate = GlobalFunction.shared.oneMonthAgo() {
            self.fromDateButton.setTitle(monthAgoDate.stringFromDate(), for: .normal)
        }
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.keyboardDismissMode = .onDrag
        self.collectionView.register(UINib(nibName: cellIdentifiers, bundle: nil), forCellWithReuseIdentifier: cellIdentifiers)
        self.collectionView.register(UINib(nibName: gridCellIdentifiers, bundle: nil), forCellWithReuseIdentifier: gridCellIdentifiers)
        self.collectionView.register(UINib(nibName: headerIdentifiers, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifiers)
        setUpSwipable()
    }
    
    private func setUpSwipable() {
        swipableExtension = CollectionSwipableCellExtension(with: collectionView)
        swipableExtension?.delegate = self
        swipableExtension?.isEnabled = true
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
        
        let filter: String? = self.filterButton.titleLabel?.text == "Sort By" ? nil : self.filterButton.titleLabel?.text
        viewModel.fetchNews(query: query, fromDate: self.getSelectedDateInString(), sortBy: filter, reset: reset)
    }
    
    private func getSelectedDateInString() -> String? {
        if let date = self.fromDateButton.titleLabel?.text,
           date != "From Date"  {
            return date
        }
        return nil
    }
    
    private func createSingleColumnLayout(index: Int) -> CGSize {
        let article = viewModel.article(at: index)
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
    
    private func createGridLayout() -> CGSize {
        let width = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: width + 120.0)
    }
    
}

// MARK: - UICollectionView Delegate, DataSource & FlowLayout Delegate

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = self.isGridLayout ? gridCellIdentifiers : cellIdentifiers
        let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! NewsCollectionViewCell
        let article = viewModel.article(at: indexPath.item)
        cell.populate(with: article)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.isGridLayout {
            return createGridLayout()
        } else {
            return self.createSingleColumnLayout(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.resetSwipableActions()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = NewsDetailViewController(article: viewModel.article(at: indexPath.item))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: headerIdentifiers,
                                                                     for: indexPath) as! CollectionHeaderView
        header.searchTextLabel.text = (searchBar.text == "") ? "apple" : searchBar.text
        header.urlLabel.text = viewModel.getRequestedURL()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let calculatedWidth = collectionView.frame.width - 80
        let headerHeight = viewModel.getRequestedURL()?.height(withConstrainedWidth: calculatedWidth, font: .systemFont(ofSize: 17.0)) ?? 150.0
        return CGSize(width: collectionView.frame.width, height: headerHeight + 64)
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
    
    
    @IBAction func layoutChangeButtonAction(_ sender: UIButton) {
        self.isGridLayout.toggle()
        self.collectionView.reloadData()
        let buttonTitle = self.isGridLayout ? "list" : "grid"
        self.layoutChangeButton.setImage(UIImage(named: buttonTitle), for: .normal)
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        let options = ["None", "Relevancy", "PublishedAt", "Popularity"]
        let bottomSheet = PickerBottomSheetViewController(options: options)
        bottomSheet.onOptionSelected = { [weak self] selectedOption in
            guard let self = self else { return }
            let filterOption = (selectedOption == "None") ? "Sort By" : selectedOption
            self.filterButton.setTitle(filterOption, for: .normal)
            self.toggleLoader(isShow: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                self.callFetchNewsAPI(reset: true)
            }
        }
        bottomSheet.modalPresentationStyle = .overFullScreen
        present(bottomSheet, animated: true, completion: nil)
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
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text,
              !searchText.isEmpty else {
            return
        }
        
        if searchText.count <= 2 {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.searchMinimumLimit)
            return
        }
        
        self.toggleLoader(isShow: true)
        self.callFetchNewsAPI(reset: true)
    }
    
}

// MARK: - UIScrollView Delegate

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

// MARK: - Collection Swipable Cell Extension Delegate
extension SearchViewController: CollectionSwipableCellExtensionDelegate {
    
    func isSwipable(itemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func swipableActionsLayout(forItemAt indexPath: IndexPath) -> CollectionSwipableCellLayout? {
        let article = viewModel.article(at: indexPath.item)
        let actionLayout = CollectionSwipableCellOneButtonLayout(buttonWidth: 150, insets: .zero, direction: .leftToRight)
        actionLayout.button.backgroundColor = articalViewModel.isArticleInFavorites(article) ? .red : .green
        actionLayout.button.setTitle(articalViewModel.isArticleInFavorites(article) ? "Delete From Favorite" : "Add To Favorite", for: .normal)
        actionLayout.button.tintColor = articalViewModel.isArticleInFavorites(article) ? .white : .black
        
        actionLayout.action = { [weak self] in
            self?.handelSwipeToFavourite(atIndexPath: indexPath)
        }
        
        return actionLayout
    }
    
    private func handelSwipeToFavourite(atIndexPath indexPath: IndexPath) {
        let article = viewModel.article(at: indexPath.item)
        if articalViewModel.isArticleInFavorites(article) {
            articalViewModel.removeArticleFromFavorites(article)
            self.view.makeToast(Strings.AlertMessage.removedFromFavourite)
        } else {
            articalViewModel.saveArticleToFavorites(article)
            self.view.makeToast(Strings.AlertMessage.addedInFavourite)
        }
        self.collectionView.reloadData()
    }
    
}

//
//  FavoritesViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    private let viewModel = ArticleViewModel()
    private let cellIdentifiers = NewsTableViewCell.identifier
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
        self.setUpTableView()
        self.setUpViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.viewModel.fetchFavoriteArticles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

// MARK: - Setup

extension FavoritesViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
    }
    
    private func setUpViewModel() {
        
        self.viewModel.onFavoritesUpdated = { [weak self] in
            guard let self = self else { return }
            favoriteTableView.reloadData()
        }
        
    }
    
    private func setUpTableView() {
        let nib = UINib(nibName: cellIdentifiers, bundle: nil)
        self.favoriteTableView.register(nib, forCellReuseIdentifier: cellIdentifiers)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.favoriteArticles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.populate(with: viewModel.favoriteArticles[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = NewsDetailViewController(article: viewModel.favoriteArticles[indexPath.section])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let article = viewModel.favoriteArticles[indexPath.section]
            viewModel.removeArticleFromFavorites(article)
        }
    }
}

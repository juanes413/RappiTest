//
//  ViewController.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 9/12/21.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var uiTabBar: UITabBar!
    
    private enum ReuseIdentifiers: String {
        case movieItemUITableViewCell
    }
    
    private var contentWidth: CGFloat {
        return (collectionView.bounds.width/2)-17
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var typeCategory: TypeCategory = .popular
    var databaseManager = DataBaseManager()
    
    private var mValues = [MovieItem]()
    private var mValuesFiltered = [MovieItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureSearchBar()
        self.configureCollectionViewAndTabBar()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurateNavigationView()
    }
    
    private func configurateNavigationView() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func openDetail(movieItem: MovieItem) {
        if let destination = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            destination.movieItem = movieItem
            destination.providesPresentationContextTransitionStyle = true
            destination.definesPresentationContext = true
            destination.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    private func loadData() {
        DispatchQueue.main.async {
            self.databaseManager.saveMovieToDb(typeCategory: self.typeCategory, completionBlock: {
                self.mValues = self.databaseManager.loadMoviesFromDb(typeCategory: self.typeCategory)
                self.mValuesFiltered = self.mValues
                self.reloadData()
            })
        }
    }
    
}
// MARK: - UISearchBar
extension MainViewController: UITabBarDelegate {
    
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tab = item.tag
        if tab != typeCategory.rawValue, let category = TypeCategory(rawValue: tab) {
            self.typeCategory = category
            self.loadData()
            self.changeTitle()
        }
    }
    
}
// MARK: - UISearchBar
extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
       filteredList()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.mValuesFiltered = mValues
        self.reloadData()
    }
    
    func filteredList() {
        if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
            mValuesFiltered = mValues.filter {
                item in return (item.title.lowercased().contains(searchText))
            }
        } else {
            mValuesFiltered = mValues
        }
        self.reloadData()
    }
    
}
// MARK: - UICollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentWidth, height: 356)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mValuesFiltered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifiers.movieItemUITableViewCell.rawValue, for: indexPath) as? MovieUICollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = mValuesFiltered[indexPath.row]
        
        cell.labelTitle.text = item.title
        cell.labelDate.text = item.releaseDate
        
        if let url = URL(string: APIService.baseUrlImage + item.posterPath) {
            cell.imageView.sd_setImage(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = mValuesFiltered[indexPath.row]
        openDetail(movieItem: item)
    }
}
// MARK: - UI
extension MainViewController {
    
    //Configuracion UI, se agrega un searchcontroller para el buscador
    private func configureSearchBar() {
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.delegate = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
    }
    
    //Configuracion de la collectionView y TabBar
    private func configureCollectionViewAndTabBar() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.uiTabBar.delegate = self
        self.uiTabBar.selectedItem = uiTabBar.items?.first
    }
    
    private func changeTitle() {
        self.navigationItem.title = typeCategory.name
    }
    
    //Refrescar informacion
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

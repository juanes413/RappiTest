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
    
    private var mValues = [MovieItem]()
    private var mValuesFiltered = [MovieItem]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private enum ReuseIdentifiers: String {
        case movieItemUITableViewCell
    }
    
    private var typeCategory: TypeCategory = .popular
    
    private lazy var viewModelMovie = {
        MovieViewModel(viewModelToViewBinding: self)
    }()
    
    private var contentWidth: CGFloat {
        return (collectionView.bounds.width/2)-17
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        mValuesFiltered.append(MovieItem(adult: false, backdropPath: "", genreIDS: [], id: 0, originalTitle: "", overview: "", popularity: 0.0, posterPath: "/2jVVDtDaeMxmcvrz2SNyhMcYtWc.jpg", releaseDate: "2021-12-01", title: "Encanto", video: false, voteAverage: 0.0, voteCount: 0))
        
        mValuesFiltered.append(MovieItem(adult: false, backdropPath: "", genreIDS: [], id: 0, originalTitle: "", overview: "", popularity: 0.0, posterPath: "/odBUpjZGxY3y7FBo5NBtEYGJf5r.jpg", releaseDate: "2021-12-01", title: "Spiderman no way home", video: false, voteAverage: 0.0, voteCount: 0))
        
        */
        self.configureSearchBar()
        self.configureCollectionViewAndTabBar()
        
        viewModelMovie.loadMoviesFromService(typeCategory: typeCategory)
    }
    
    private func changeTitle() {
        self.navigationItem.title = typeCategory.name
    }
    
}
// MARK: - UISearchBar
extension MainViewController: UITabBarDelegate {
    
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tab = item.tag
        if tab != typeCategory.rawValue {
            typeCategory = TypeCategory(rawValue: tab)!
            self.changeTitle()
        }
    }
    
}
// MARK: - UISearchBar
extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
            mValuesFiltered = mValues.filter {
                item in return (item.title.lowercased().contains(searchText))
            }
        } else {
            mValuesFiltered = mValues
        }
        self.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.mValuesFiltered = mValues
        self.reloadData()
    }
    
}
// MARK: - UICollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentWidth, height: contentWidth*2)
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
    
    //Refrescar informacion
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}
// MARK: - ViewModel
extension MainViewController: MovieViewModelToViewBinding {
    
    func serviceMovieResult(typeCategory: TypeCategory, results: [MovieItem]) {
        self.mValues = results
        self.mValuesFiltered = self.mValues
        self.reloadData()
    }
    
    func serviceError() {
        print("error")
    }
    
}

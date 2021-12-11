//
//  DetailViewController.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 11/12/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var movieItem: MovieItem?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func updateUI() {
        guard let movieItem = self.movieItem else { return }
        
        if let url = URL(string: APIService.baseUrlImage + movieItem.posterPath) {
            imageView.sd_setImage(with: url)
        }
        
    }
    
}

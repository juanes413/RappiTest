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
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var movieItem: MovieItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurateNavigationView()
    }
    
    private func configurateNavigationView() {
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        
        //self.extendedLayoutIncludesOpaqueBars = true
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func updateUI() {
        guard let movieItem = self.movieItem else { return }
        
        if let url = URL(string: APIService.baseUrlImage + movieItem.posterPath) {
            imageView.sd_setImage(with: url)
        }
        
        labelTitle.text = movieItem.title
        labelDate.text = movieItem.releaseDate
        labelAverage.text = String(movieItem.voteAverage)
        labelDescription.text = movieItem.overview
        gradientView()
    }
    
    private func gradientView(){
        
        let gradient = CAGradientLayer()
        let colorClear = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.0).cgColor
        let colorBlack = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.6).cgColor
        
        gradient.frame = backgroundView.bounds
        gradient.colors = [colorBlack, colorClear, colorBlack]
        gradient.locations = [0.0, 0.5, 1.0]
        
        backgroundView.layer.insertSublayer(gradient, at: 0)
    }
    
}

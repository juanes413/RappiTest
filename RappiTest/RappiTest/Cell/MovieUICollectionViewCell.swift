//
//  MovieUITableViewCell.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 9/12/21.
//
import UIKit

class MovieUICollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
    }
    
}



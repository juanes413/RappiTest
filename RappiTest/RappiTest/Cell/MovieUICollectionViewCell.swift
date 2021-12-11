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
    
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderColor  =  UIColor.gray.cgColor
        contentView.layer.borderWidth = 0.1
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowColor =  UIColor.gray.cgColor
        contentView.layer.shadowRadius = 2.0
        contentView.layer.shadowOffset = CGSize(width:0.0, height: 0.0)
        contentView.layer.masksToBounds = true
    }
    
}



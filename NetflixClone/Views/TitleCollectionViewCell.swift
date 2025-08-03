//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by Родион Холодов on 01.08.2025.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        let stringUrl = "https://image.tmdb.org/t/p/w500\(model)"
        guard let url = URL(string: stringUrl) else { return }
        posterImageView.sd_setImage(with: url)
    }
    
}

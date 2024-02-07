//
//  PictureCell.swift
//  Unsplash
//
//  Created by Patricia Costin on 06.10.2023.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    private  let cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
    }
    
    func setUp(imageUrlString: String) {
        let imageURL = URL(string: imageUrlString)
        imageView.sd_setImage(with: imageURL)
    }
}

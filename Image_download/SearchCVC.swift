//
//  SearchCVC.swift
//  Image_download
//
//  Created by Macbook on 24/03/22.
//

import UIKit
import SDWebImage

class SearchCVC: UICollectionViewCell {

    @IBOutlet weak var imagee: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updatecell(url: URL) {
        self.imagee.sd_imageIndicator = SDWebImageActivityIndicator.large
        self.imagee.sd_setImage(with: url)
    }
}

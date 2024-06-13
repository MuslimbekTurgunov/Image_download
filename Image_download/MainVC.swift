//
//  MainVC.swift
//  Image_download
//
//  Created by Macbook on 24/03/22.
//

import UIKit
import SDWebImage

class MainVC: UIViewController {
    
    
    @IBOutlet weak var imageRandom: UIImageView!
    @IBOutlet weak var collecView: UICollectionView! {
        didSet {
            collecView.delegate = self
            collecView.dataSource = self
            collecView.register(UINib(nibName: "MainCVC", bundle: nil), forCellWithReuseIdentifier: "MainCVC")
        }
    }
    
    var imagess: [URL] = []
    
    var currentPage: Int = 1
    var perPage: Int = 10
    var isPageRefreshing: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.shared.getRandomImages { urll in
            self.imageRandom.sd_imageIndicator = SDWebImageActivityIndicator.large
            self.imageRandom.sd_setImage(with: urll)
            print(urll, "salom")
        }
        
        API.shared.getLatestImages(type: .small, page: self.currentPage, perPage: self.perPage) { imag in
            self.imagess = imag
            self.collecView.reloadData()
        }
        
    }


}


// MARK: - collec delegate datasourse

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagess.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collecView.dequeueReusableCell(withReuseIdentifier: "MainCVC", for: indexPath) as? MainCVC else { return UICollectionViewCell() }
        cell.updatecell(url: imagess[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InfoVC.init(nibName: "InfoVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collecView.contentOffset.y >= (self.collecView.contentSize.height - self.collecView.bounds.size.height)) {
                if !isPageRefreshing {
                    isPageRefreshing = true
                    currentPage += 1
                    API.shared.getLatestImages(type: .small, page: self.currentPage, perPage: self.perPage) { imgs in
                        self.imagess = self.imagess + imgs
                        self.collecView.reloadData()
                        self.isPageRefreshing = false
                    }
                }
            }
    }
}

//
//  SearchVC.swift
//  Image_download
//
//  Created by Macbook on 24/03/22.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var collecView: UICollectionView!{
        didSet {
            collecView.delegate = self
            collecView.dataSource = self
            collecView.register(UINib(nibName: "SearchCVC", bundle: nil), forCellWithReuseIdentifier: "SearchCVC")
        }

    }
    
    var imagess: [URL] = []
    
    var currentPage: Int = 1
    var perPage: Int = 10
    var isPageRefreshing: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}


// MARK: - collec delegate datasourse

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagess.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collecView.dequeueReusableCell(withReuseIdentifier: "SearchCVC", for: indexPath) as? SearchCVC else { return UICollectionViewCell() }
        cell.updatecell(url: imagess[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collecView.contentOffset.y >= (self.collecView.contentSize.height - self.collecView.bounds.size.height)) {
                if !isPageRefreshing {
                    isPageRefreshing = true
                    currentPage += 1
            API.shared.getLatestaSEARCH(type: .small, textName: self.searchBar.text!, page: self.currentPage, perPage: self.perPage) { immmm in
                        self.imagess = self.imagess + immmm
                        self.collecView.reloadData()
                        self.isPageRefreshing = false
                    }
                }
            }

    }

    
    
    
}


//MARK: searchBar delegate

extension SearchVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        API.shared.getLatestaSEARCH(type: .small, textName: self.searchBar.text!, page: self.currentPage, perPage: self.perPage) { urle in
            self.imagess = urle
            print("sddsdsdsdsds", urle)
            self.collecView.reloadData()

        }
    }

}

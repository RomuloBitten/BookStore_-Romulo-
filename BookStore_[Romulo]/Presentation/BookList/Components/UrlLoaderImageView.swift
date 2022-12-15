//
//  UrlLoaderImageView.swift
//  BookStore_[Romulo]
//
//  Created by Romulo B. Mantovani on 15/12/22.
//

import Foundation
import UIKit

class UrlLoaderImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.resetImage()
    }
    
    func resetImage() {
        //self.image = tempImage
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func loadFrom(URLAddress: String) {
            guard let url = URL(string: URLAddress) else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let imageData = try? Data(contentsOf: url) {
                    if let loadedImage = UIImage(data: imageData) {
                            self.image = loadedImage
                    }
                }
            }
        }
}

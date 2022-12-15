//
//  BookItemTableViewCell.swift
//  BookStore_[Romulo]
//
//  Created by Romulo B. Mantovani on 15/12/22.
//

import Foundation
import UIKit

class BookItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "BookItemTableViewCell"
    
    lazy var urlImageView: UrlLoaderImageView = {
        UrlLoaderImageView(frame: .zero)
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var imageUrl: String = "" {
        didSet {
            self.urlImageView.loadFrom(URLAddress: self.imageUrl)
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        self.setupImageView()
        self.setupTitleLabel()
    }
    
    private func setupImageView() {
        self.contentView.addSubview(self.urlImageView)
        
        self.urlImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.urlImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.urlImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.urlImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 32).isActive = true
        self.urlImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 8).isActive = true
        
        self.urlImageView.contentMode = .scaleAspectFit
    }
    
    func setupTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
    }
    
}

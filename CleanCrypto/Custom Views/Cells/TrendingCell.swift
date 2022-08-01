//
//  TrendingCell.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 7/29/22.
//

import UIKit

class TrendingCell: UITableViewCell {
    
    static let reuseID = "TrendingCell"
    
    let coinImageView = CCCoinImageView(frame: .zero)
    let nameLabel = CCTitleLabel(textAlignment: .left, fontSize: 18)
    let symbolLabel = CCSecondaryTitleLabel(fontSize: 18)
    let priceLabel = CCTitleLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    func set(item: Item) {
        nameLabel.text = item.name
        coinImageView.downloadImage(fromURL: item.large)
        symbolLabel.text = item.symbol
        priceLabel.text = "\(item.priceUsd.formatted(.currency(code: "USD")))"
    }
    
    private func configure() {
        selectionStyle = .none
        
        addSubViews(coinImageView, nameLabel, symbolLabel, priceLabel)
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            coinImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            coinImageView.heightAnchor.constraint(equalToConstant: 55),
            coinImageView.widthAnchor.constraint(equalToConstant: 55),
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            priceLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TweetCell.swift
//  STTwitterDebounceDemo
//
//  Created by Vinicius Mangueira on 10/08/19.
//  Copyright © 2019 Vinicius Mangueira . All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    let nameLabel = UILabel(text: "Username", font: .boldSystemFont(ofSize: 16), textColor: .black)
    let tweetTextLabel = UILabel(text: "Tweet Text MultiLines", font: .systemFont(ofSize: 16), textColor: .darkGray, numberOfLines: 0)
    let profileImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       // profileImageView.layer.borderWidth = 0.5
        profileImageView.layer.cornerRadius = 25
        hstack(
            profileImageView.withSize(.init(width: 50, height: 50)),
            stack(nameLabel, tweetTextLabel, spacing: 8),
            spacing: 20,
            alignment: .top
        ).withMargins(.allSides(24))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class RoundeImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ImageViewCell.swift
//  Vigor
//
//  Created by Jason Shu on 6/26/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

class ImageViewCell: UITableViewCell {

    var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView

    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(mainImageView)
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = self.size.width / self.size.height
        return widthRatio
    }
}

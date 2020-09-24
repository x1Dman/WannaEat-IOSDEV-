//
//  CollectionCell.swift
//  WannaEat
//
//  Created by 18579118 on 25.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
	var image = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(image)
		setupConstaints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupConstaints() {
		image.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			image.widthAnchor.constraint(equalTo: widthAnchor),
			image.heightAnchor.constraint(equalTo: heightAnchor),
			image.trailingAnchor.constraint(equalTo: trailingAnchor),
			image.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

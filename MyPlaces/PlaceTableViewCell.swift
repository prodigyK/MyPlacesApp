//
//  PlaceTableViewCell.swift
//  MyPlaces
//
//  Created by Admin on 13.07.2020.
//  Copyright © 2020 TheProdigy. All rights reserved.
//

import UIKit
import Cosmos

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ratingStack: UIStackView!
    @IBOutlet weak var cosmoView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCosmosStars(_ rating: Double) {
        
        
    }

    func setupRatingStars(_ rating: Int) {
        
        cleanStars()
        
        for star in 1...5 {
            
            let emptyStar = UIImage(named: "emptyStar")
            let filledStar = UIImage(named: "filledStar")
            
            let image = (star <= rating) ? filledStar : emptyStar
            
            let imageView = UIImageView(image: image)
            let viewRect = CGRect(x: 0, y: 0, width: 17, height: 17)
            imageView.contentMode = .scaleAspectFit
            imageView.frame(forAlignmentRect: viewRect)
            let viewForStar = UIView(frame: viewRect)
            viewForStar.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 17.0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 17.0).isActive = true
            
            ratingStack.addArrangedSubview(viewForStar)
        }
    }
    
    private func cleanStars() {
        
        if !ratingStack.subviews.isEmpty {
            
            for view in ratingStack.subviews {
                ratingStack.removeArrangedSubview(view)
            }
        }
    }
}

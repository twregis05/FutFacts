//
//  SearchResultTableViewCell.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/17/25.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var details: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var labelsStack: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func didMoveToSuperview()
    {
        super.didMoveToSuperview()

        if resultImage != nil, labelsStack != nil
        {
            resultImage.translatesAutoresizingMaskIntoConstraints = false
            labelsStack.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                resultImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                resultImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                resultImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                resultImage.widthAnchor.constraint(equalTo: resultImage.heightAnchor),

                labelsStack.leadingAnchor.constraint(equalTo: resultImage.trailingAnchor, constant: 12),
                labelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                labelsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

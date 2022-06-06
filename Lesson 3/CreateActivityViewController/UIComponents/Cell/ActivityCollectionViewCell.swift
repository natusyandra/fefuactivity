//
//  CollectionViewCell.swift
//  fefuactivity
//
//  Created by Котик on 06.06.2022.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActivityCollectionViewCell"
    
    private let activityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 102, height: 84)
        imageView.image = UIImage(named: "bikeImage")
        return imageView
    }()
    
    private let activityTypeView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Вело"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityTypeView.frame = contentView.bounds
        activityImageView.frame = contentView.bounds
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.layer.cornerRadius = 13.91
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        contentView.backgroundColor = .white
        contentView.addSubview(activityTypeView)
        contentView.addSubview(activityImageView)
        contentView.clipsToBounds = true
        
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            
            activityImageView.widthAnchor.constraint(equalToConstant: 102),
            activityImageView.heightAnchor.constraint(equalToConstant: 84),
            activityImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 112),
            activityImageView.topAnchor.constraint(equalTo: topAnchor),
            
            activityTypeView.widthAnchor.constraint(equalToConstant: 86),
            activityTypeView.heightAnchor.constraint(equalToConstant: 24),
            activityTypeView.leftAnchor.constraint(equalTo: leftAnchor,constant: 16)
        ])
}

}

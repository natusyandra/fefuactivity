//
//  Cell.swift
//  fefuactivity
//
//  Created by Котик on 11.05.2022.
//

import UIKit


protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_cell: FormTableViewCell)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    public weak var delegate: FormTableViewCellDelegate?
    
    public let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let meansLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let meansSymbol: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bikeIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public let timeAgoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(distanceLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(meansLabel)
        contentView.addSubview(meansSymbol)
        contentView.addSubview(timeAgoLabel)
        selectionStyle = .none
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        backgroundColor = .clear
        
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            distanceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            distanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 1),
            
            meansSymbol.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            meansSymbol.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            meansSymbol.heightAnchor.constraint(equalToConstant: 20),
            meansSymbol.widthAnchor.constraint(equalToConstant: 13),
            
            meansLabel.leftAnchor.constraint(equalTo: meansSymbol.rightAnchor, constant: 5.5),
            meansLabel.topAnchor.constraint(equalTo: meansSymbol.topAnchor, constant: 0),
            meansLabel.bottomAnchor.constraint(equalTo: meansSymbol.bottomAnchor, constant: 0),
            meansLabel.heightAnchor.constraint(equalToConstant: 18),
            
            timeAgoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            timeAgoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            timeAgoLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    public func setupData(_ data: ActivityEntity) {
        
        let value = (data.distance).rounded() / 1000
        let roundText = String(format: "%.1f", value)
        distanceLabel.text = "\(roundText) км"
        
        meansLabel.text = data.type
        
        let hours = data.timerData / 3600
        let minutes = data.timerData / 60 % 60
        let restTime = ((hours<10) ? "" : "") + String(hours) + " часа" + ((minutes<10) ? " " : "") + String(minutes) + " минут"
        timeLabel.text = "\(restTime)"
        
        let date = Date()
        let timeAgoFormatted = RelativeDateTimeFormatter()
        timeAgoFormatted.unitsStyle = .full
        timeAgoFormatted.dateTimeStyle = .named
        let string = timeAgoFormatted.localizedString(for: data.finishTime ?? Date(), relativeTo: date)
        timeAgoLabel.text = string
    }
}

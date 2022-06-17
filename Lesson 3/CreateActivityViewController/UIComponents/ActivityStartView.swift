//
//  ActivityStartUI.swift
//  fefuactivity
//
//  Created by Котик on 06.06.2022.
//

import UIKit

protocol ActivityStartViewProtocol: AnyObject {
    func selectItem(_ index: Int)
    func didStartButtonTapped()
}

class ActivityStartView: UIView {
    
    private let goLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Погнали? :("
        label.font = UIFont.systemFont(ofSize: 22, weight: . semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: MyButton = {
        let button = MyButton()
        button.setTitle("Старт", for: .normal)
        return button
    }()
    
    private lazy var activityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    public var delegate: ActivityStartViewProtocol?
    
    public var dataSource: [ActivityStartItem] = [] {
        didSet {
            activityCollectionView.reloadData()
            activityCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        }
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        backgroundColor = .white
        setupViews()
        layoutConstraints()
        
        startButton.addTarget(self,
                              action: #selector(startButtonTap),
                              for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(startButton)
        addSubview(goLabel)
        addSubview(activityCollectionView)
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            
            goLabel.widthAnchor.constraint(equalToConstant: 133),
            goLabel.heightAnchor.constraint(equalToConstant: 28),
            goLabel.topAnchor.constraint(equalTo: topAnchor, constant: 33),
            goLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 140),
            
            activityCollectionView.topAnchor.constraint(equalTo: goLabel.bottomAnchor, constant: 10),
            activityCollectionView.leftAnchor.constraint(equalTo: leftAnchor,constant: 0),
            activityCollectionView.rightAnchor.constraint(equalTo: rightAnchor,constant: 0),
            activityCollectionView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -30),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            startButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    @objc func startButtonTap() {
        delegate?.didStartButtonTapped()
    }
}

extension ActivityStartView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell.identifier, for: indexPath) as!
        ActivityCollectionViewCell
        cell.setupData(dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 214, height: 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectItem(indexPath.row)
    }
}


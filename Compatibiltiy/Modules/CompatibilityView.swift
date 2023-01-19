//
//  CompatibilityView.swift
//  Compatibiltiy
//
//  Created by Nirajan on 18/1/2023.
//

import UIKit

class CompatibilityView: UIView {
    // MARK: UIs
    lazy var firstView: DropViewView = {
        let view = DropViewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondView: DropViewView = {
        let view = DropViewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var compatibilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dragInteractionEnabled = true
        
        /// cell register
        collectionView.register(CompatibilityCollectionViewCell.self, forCellWithReuseIdentifier: "CompatibilityCollectionViewCell")
        
        return collectionView
    }()
    
    // MARK: overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: other functions
    private func setup() {
        generateView()
    }

    // MARK: generateView
    private func generateView() {
        addSubview(firstView)
        addSubview(secondView)
        addSubview(compatibilityLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            firstView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            firstView.heightAnchor.constraint(equalToConstant: 150),
            firstView.widthAnchor.constraint(equalToConstant: 150),
            
            secondView.topAnchor.constraint(equalTo: firstView.topAnchor),
            secondView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            secondView.widthAnchor.constraint(equalTo: firstView.widthAnchor),
            secondView.heightAnchor.constraint(equalTo: firstView.heightAnchor),
            
            compatibilityLabel.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 60),
            compatibilityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            compatibilityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: compatibilityLabel.bottomAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

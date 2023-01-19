//
//  CompatibilityCollectionViewCell.swift
//  Compatibiltiy
//
//  Created by Nirajan on 18/1/2023.
//

import UIKit

class CompatibilityCollectionViewCell: UICollectionViewCell {
    // MARK: UIs
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // MARK: overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: other functions
    private func setup() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.backgroundColor = .white
        generateView()
    }

    // MARK: generateView
    private func generateView() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: configure
    func configure(with fish: Fish) {
        titleLabel.text = fish.name
    }
}

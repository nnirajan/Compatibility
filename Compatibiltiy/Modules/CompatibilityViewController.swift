//
//  CompatibilityViewController.swift
//  Compatibiltiy
//
//  Created by Nirajan on 18/1/2023.
//

import UIKit

class CompatibilityViewController: UIViewController {
    // MARK: properties
    private var screenView: CompatibilityView
    
    private var dragView: UIView?
    
    private var fishes = [Fish]()
    
    // MARK: initialization
    init(screenView: CompatibilityView) {
        self.screenView = screenView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        observeEvents()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = screenView
    }
    
    // MARK: observeEvents
    private func observeEvents() {
        screenView.firstView.selectionClosure = { [weak self] _ in
            guard let self = self else { return }
            self.getCompatibility()
        }
        
        screenView.secondView.selectionClosure = { [weak self] _ in
            guard let self = self else { return }
            self.getCompatibility()
        }
    }
    
    // MARK: other functions
    private func setup() {
        setupCollectionView()
    }
    
    // MARK: setupCollectionView
    private func setupCollectionView() {
        screenView.collectionView.dataSource = self
        screenView.collectionView.delegate = self
        screenView.collectionView.dragDelegate = self
    }
    
    // MARK: getCompatibility
    private func getData() {
        fishes = Bundle.main.decode(.compatibility)
        screenView.collectionView.reloadData()
    }
    
    // MARK: getCompatibility
    private func getCompatibility() {
        guard let firstViewFish = screenView.firstView.fish,
              let secondViewFish = screenView.secondView.fish
        else { return }
        
        if let firstFish = fishes.first(where: { $0.name == firstViewFish.name }),
           let compatibility = firstFish.compatibility.first(where: { $0.name == secondViewFish.name })
        {
            screenView.compatibilityLabel.text = compatibility.score.rawValue
        } else {
            screenView.compatibilityLabel.text = ""
        }
    }
}

// MARK: UICollectionViewDataSource
extension CompatibilityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fish = fishes[indexPath.item]
        
        let cell: CompatibilityCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompatibilityCollectionViewCell", for: indexPath) as! CompatibilityCollectionViewCell
        cell.configure(with: fish)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CompatibilityViewController: UICollectionViewDelegate {
}

// MARK: UICollectionViewDelegateFlowLayout
extension CompatibilityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
}

// MARK: UICollectionViewDragDelegate
extension CompatibilityViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let fish = fishes[indexPath.item]
        
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(fish),
              let json = String(data: encoded, encoding: .utf8)
        else {
            return []
        }
        
        let itemProvider = NSItemProvider(object: json as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = fish
        return [dragItem]
    }
}

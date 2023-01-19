//
//  SelectionView.swift
//  Compatibiltiy
//
//  Created by Nirajan on 18/1/2023.
//

import UIKit

class DropViewView: UIView {
    // MARK: properties
    var selectionClosure: ((Fish)->Void)?
    
    var fish: Fish?
    
    // MARK: UIs
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        generateView()
        
        // Enable dropping onto the image view (see ViewController+Drop.swift).
        let dropInteraction = UIDropInteraction(delegate: self)
        addInteraction(dropInteraction)
    }
    
    // MARK: generateView
    private func generateView() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: UIDropInteractionDelegate
extension DropViewView: UIDropInteractionDelegate {
    /**
     Ensure that the drop session contains a drag item with a data representation that the view can consume.
     */
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    /**
     Required delegate method: return a drop proposal, indicating how the view is to handle the dropped items.
     */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        guard let superview = self.superview else {
            fatalError()
        }
        
        let dropLocation = session.location(in: superview)
        
        updateLayers(forDropLocation: dropLocation)
        
        let operation: UIDropOperation
        
        if self.frame.contains(dropLocation) {
            /*
             If you add in-app drag-and-drop support for the .move operation,
             you must write code to coordinate between the drag interaction
             delegate and the drop interaction delegate.
             */
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            // Do not allow dropping outside of the image view.
            operation = .cancel
        }
        
        return UIDropProposal(operation: operation)
    }
    
    func updateLayers(forDropLocation dropLocation: CGPoint) {
        if frame.contains(dropLocation) {
            layer.borderWidth = 5.0
        } else {
            layer.borderWidth = 0.0
        }
    }
    
    /**
         This delegate method is the only opportunity for accessing and loading the data representations offered in the drag item.
    */
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // Consume drag items (in this example, of type UIImage).
        _ = session.loadObjects(ofClass: String.self) { [weak self] items in
            guard let self = self,
                  let item = items.first
            else { return }
            let data = Data(item.utf8)
            do {
                let decoder = JSONDecoder()
                let fish = try decoder.decode(Fish.self, from: data)
                self.titleLabel.text = fish.name
                
                self.fish = fish
                
                self.selectionClosure?(fish)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

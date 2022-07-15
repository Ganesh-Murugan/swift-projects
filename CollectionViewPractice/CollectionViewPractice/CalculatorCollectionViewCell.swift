//
//  CalculatorCollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import UIKit

class CalculatorCollectionViewCell: UICollectionViewCell {

    var cellView: UIView = {
        let cell = UIView()
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }()
    
    var cellLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.setFont(.title)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellView.addSubview(cellLabel)
        cellView.frame = contentView.bounds
        cellLabel.frame = contentView.bounds
        
        
        contentView.addSubview(cellView)
    }
    
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel(_ type: [Calculator],_ indexPath: Int) {
        self.cellLabel.text = type[indexPath].value
    }
    func applyColor(_ index: Int) {
        let operators = [3,7,11,15,18]
        self.backgroundColor = index < 3 ? UIColor.gray : operators.contains(index) ? UIColor.systemOrange : UIColor.systemGray2
    }
    func highlightColor(_ value : Bool) {
        if value {
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.yellow.cgColor
        } else  {
            self.layer.borderWidth = 0
        }
    }
}



//cellValue.translatesAutoresizingMaskIntoConstraints = false
//cellValue.heightAnchor.constraint(equalTo: heightAnchor, constant: 5).isActive = true
//cellValue.widthAnchor.constraint(equalTo: widthAnchor, constant: 5).isActive = true
//cellValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true

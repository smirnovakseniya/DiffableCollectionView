//
//  ContactCell.swift
//  KSDiffableCollection
//
//  Created by Ксения Смирнова on 15.04.22.
//

import UIKit

class ContactCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    lazy var nameLbl: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 25, weight: .medium)
        lb.textColor = .white
        return lb
    }()
    
    lazy var bg: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 25
        v.layer.shadowOpacity = 0.1
        v.layer.shadowOffset = .init(width: 2, height: 5)
        v.layer.shadowRadius = 5
        v.backgroundColor = .brown
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var contact: String? {
        didSet {
            nameLbl.text = contact
            colorCell(name: contact!)
        }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func setupCell() {
        
        contentView.addSubview(bg)
        contentView.addSubview(nameLbl)
        
        NSLayoutConstraint.activate([
            
            nameLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            bg.leftAnchor.constraint(equalTo: leftAnchor),
            bg.rightAnchor.constraint(equalTo: rightAnchor),
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func colorCell(name: String) {
        switch name {
        case "1":
            bg.backgroundColor = .systemRed
        case "2":
            bg.backgroundColor = .systemOrange
        case "3":
            bg.backgroundColor = .systemYellow
        case "4":
            bg.backgroundColor = .systemGreen
        case "5":
            bg.backgroundColor = .systemBlue
        default:
            break
        }
    }
    
}


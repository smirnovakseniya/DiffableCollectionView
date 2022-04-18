//
//  CollectionVC.swift
//  KSDiffableCollection
//
//  Created by Ксения Смирнова on 15.04.22.
//

import UIKit

fileprivate typealias NumberDataSource = UICollectionViewDiffableDataSource<CollectionVC.Section, String>
fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<CollectionVC.Section, String>

class CollectionVC: UIViewController {
    
    fileprivate enum Section {
        case main
    }
    
    //MARK: - Variables
    
    var allCells: [String] = ["1", "2", "3", "4", "5"]
    var predCells: [String] = []
    
    let cellId = "cellId"
    private var numbers = [String]()
    private var dataSource: NumberDataSource!
    private var collectionView: UICollectionView!
    
    fileprivate var snapshot = DataSourceSnapshot()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        predCells = allCells
        
        addNavigationItem()
        
        createData()
        configureHierarchy()
        configureDataSource()
        
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
    
    //MARK: - Functions
    
    func addNavigationItem() {
        navigationItem.title = "Collection"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(reloadButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .brown
    }
    
    @objc private func reloadButtonTapped() {
        predCells = allCells
        allCells = allCells.shuffled()
        
        createData()
        configureDataSource()
        
    }
}

//MARK: - Collection View Setup

extension CollectionVC {
    
    private func createData() {
        numbers = allCells
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 50, bottom: 0, trailing: 50)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isScrollEnabled = false
        
        view.addSubview(collectionView)
    }
    
    
    private func configureDataSource() {
        
        dataSource = NumberDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, num) -> ContactCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ContactCell
            cell.number = num
            cell.layer.cornerRadius = 25
            
            self.anim(cell: cell, oneCell: "1", indexPathRow: indexPath.row)
            self.anim(cell: cell, oneCell: "2", indexPathRow: indexPath.row)
            self.anim(cell: cell, oneCell: "3", indexPathRow: indexPath.row)
            self.anim(cell: cell, oneCell: "4", indexPathRow: indexPath.row)
            self.anim(cell: cell, oneCell: "5", indexPathRow: indexPath.row)
            
            return cell
        } )
        
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(numbers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func anim(cell: ContactCell, oneCell: String, indexPathRow: Int) {
        let indexPred = self.predCells.firstIndex(of: oneCell)
        let indexNow = self.allCells.firstIndex(of: oneCell)
        var new = 0
        var pred = 0
        
        let space = 20
        
        switch indexPred {
        case 0:
            pred = space
        case 1:
            pred = Int(cell.frame.height) + space * 2
        case 2:
            pred = Int(cell.frame.height) * 2 + space * 3
        case 3:
            pred = Int(cell.frame.height) * 3 + space * 4
        case 4:
            pred = Int(cell.frame.height) * 4 + space * 5
        default:
            break
        }
        
        switch indexNow {
        case 0:
            new = space
        case 1:
            new = Int(cell.frame.height) + space * 2
        case 2:
            new = Int(cell.frame.height) * 2 + space * 3
        case 3:
            new = Int(cell.frame.height) * 3 + space * 4
        case 4:
            new = Int(cell.frame.height) * 4 + space * 5
        default:
            break
        }
        
        let centerPred = CGPoint(x: (cell.frame.width / 2) + 50, y: (cell.frame.height / 2) + CGFloat(pred))
        let centerNew = CGPoint(x: (cell.frame.width / 2) + 50, y: (cell.frame.height / 2) + CGFloat(new))
        
        if let index = indexPred, index == 0, indexPathRow == indexNow {
            cell.center = centerPred
            UIView.animate(withDuration: 0.3, delay: 0.1) {
                cell.center = centerNew
            }
        }
        if let index = indexPred, index == 1, indexPathRow == indexNow {
            cell.center = centerPred
            UIView.animate(withDuration: 0.3, delay: 0.2) {
                cell.center = centerNew
            }
        }
        if let index = indexPred, index == 2, indexPathRow == indexNow {
            cell.center = centerPred
            UIView.animate(withDuration: 0.3, delay: 0.3) {
                cell.center = centerNew
            }
        }
        if let index = indexPred, index == 3, indexPathRow == indexNow {
            cell.center = centerPred
            UIView.animate(withDuration: 0.3, delay: 0.4) {
                cell.center = centerNew
            }
        }
        if let index = indexPred, index == 4, indexPathRow == indexNow {
            cell.center = centerPred
            UIView.animate(withDuration: 0.3, delay: 0.5) {
                cell.center = centerNew
            }
        }
    }
}

//MARK: - Collection View Drag N Drop


extension CollectionVC: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = allCells[indexPath.row]
        let itemProvider = NSItemProvider.init(object: item as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
}

extension CollectionVC: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        switch coordinator.proposal.operation {
        case .move:
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            break
        default:
            return
        }
    }
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        let destIndexPath = destinationIndexPath
        guard let droppedItem = coordinator.items.first else { return }
        guard let sourceIndexPath = droppedItem.sourceIndexPath else { return }
        guard let droppedComponent = droppedItem.dragItem.localObject as? String else { return }
        
        if sourceIndexPath.row < destIndexPath.row {
            snapshot.moveItem(dataSource.itemIdentifier(for: sourceIndexPath)!,
                              afterItem: dataSource.itemIdentifier(for: destinationIndexPath)!)
        } else if sourceIndexPath.row > destIndexPath.row {
            snapshot.moveItem(dataSource.itemIdentifier(for: sourceIndexPath)!,
                              beforeItem: dataSource.itemIdentifier(for: destinationIndexPath)!)
        }
        predCells = allCells
        allCells.remove(at: sourceIndexPath.row)
        allCells.insert(droppedComponent, at: destinationIndexPath.row)
        
        dataSource.apply(snapshot, animatingDifferences: true)
        coordinator.drop(droppedItem.dragItem, toItemAt: destIndexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        guard let _ = destinationIndexPath else { return .init(operation: .forbidden) }
        return .init(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}

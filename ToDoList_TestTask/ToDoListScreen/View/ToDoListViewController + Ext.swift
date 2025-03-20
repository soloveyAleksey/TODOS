//
//  ToDoListViewController + Ext.swift
//  ToDoList_TestTask

import UIKit

// MARK: - UICollectionView DataSource
extension ToDoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.filteredTask.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoCollectionViewCell.identifire, for: indexPath) as? ToDoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let list = presenter.filteredTask[indexPath.row]
        cell.setData(from: list, index: indexPath.row)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension ToDoListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let context = UIContextMenuConfiguration(actionProvider:  { (action) -> UIMenu? in
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [weak self] _ in
                self?.presenter.presentEditTask(indexPath.row)
            }
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                self?.presenter.removeTask(at: indexPath.row)
            }
            return UIMenu(children: [edit, delete])
        })
        return context
    }
}

// MARK: - UICollectionView Delegate FlowLayout
extension ToDoListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width * 0.9
        
        return CGSize(width: width, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}

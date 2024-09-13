//
//  ToDoListViewController.swift
//  ToDoList_TestTask

import UIKit
import CoreData

protocol ToDoListViewProtocol: AnyObject {
    func updateView()
    func startActivityIndicator()
    func stopActivityIndicator()
    func showAlert(with error: String)
}

final class ToDoListViewController: UIViewController {
    
    var presenter: ToDoPresenterProtocol!
    
    private let headerView = HeaderView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadData()
    }
    
    @objc func addTaskButtonAction() {
        presenter.presentAddNewTask()
    }
}

// MARK: - ToDoListView Protocol
extension ToDoListViewController: ToDoListViewProtocol {
    func updateView() {
        collectionView.reloadData()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func showAlert(with error: String) {
        presentAlert(withError: error)
    }
}

// MARK: - ToDoCollectionCell Delegate
extension ToDoListViewController: ToDoCollectionCellDelegate {
    func doneButtonPressed(_ index: Int) {
        presenter.didButtonPressed(index)
    }
}

// MARK: - Configuration & Layout views
private extension ToDoListViewController {
    
    func initialization() {
        configureCollection()
        setupViews()
        setupConstraints()
    }

    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ToDoCollectionViewCell.self, forCellWithReuseIdentifier: ToDoCollectionViewCell.identifire)
    }

    func setupViews() {
        view.backgroundColor = .systemGray5
        collectionView.addSubview(activityIndicator)
        [headerView, collectionView].forEach { view.addSubview($0) }
    }

    func setupConstraints() {
        [headerView, activityIndicator, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

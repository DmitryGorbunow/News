//
//  FavoriteViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/19/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 18
        layout.itemSize = CGSize(width: 164, height: 191)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "NABackground")
        return collectionView
    }()
    
    private var viewModels = [NewsTestApp]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setupView() {
        title = "Избранное"
        navigationItem.backButtonTitle = ""
        view.addSubview(collectionView)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func getAllItems() {
        do {
            viewModels = try CoreDataManager.shared.context.fetch(NewsTestApp.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            // error
        }
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        
        cell.favorite = { [weak self] in
            guard let self = self else { return }
            let item = self.viewModels[indexPath.row]
            CoreDataManager.shared.deleteItem(item: item)
            self.viewModels.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullNewsViewController()
        vc.configureForFavorites(with: viewModels[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 23, left: 20, bottom: 0, right: 20)
    }

}

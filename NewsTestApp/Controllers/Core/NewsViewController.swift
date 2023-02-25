//
//  NewsViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/19/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.backgroundColor = UIColor(named: "NABackground")
        return table
    }()
    
    private var viewModels = [NewsTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "NABackground")
        title = "Новости"
        view.addSubview(tableView)
        navigationItem.backButtonTitle = ""
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    // getting news from the server and adding to viewModels
    private func fetchData() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        publishedAt: $0.publishedAt
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // deleting an article from favorites
    private func deleteFromFavorites(indexPath: IndexPath) {
        var array = [NewsTestApp]()
        do {
            array = try CoreDataManager.shared.context.fetch(NewsTestApp.fetchRequest())
        } catch {
            // error
        }
        
        for i in array {
            if i.title == viewModels[indexPath.row].title {
                CoreDataManager.shared.deleteItem(item: i)
            }
        }
    }
    
//        reaction to clicking the favorites button in the cell by the user and
//        saving the selected article in Core Data
    private func changeFavoriteStatus(indexPath: IndexPath, cell: NewsTableViewCell) {
        cell.favorite = { [weak self] in
            guard let self = self else { return }
            
            let vc = FullNewsViewController()
            vc.isFavorite.toggle()
            vc.setupFavoriteButton()
            
            if !cell.isFavorite {
                CoreDataManager.shared.createItem (
                    title: self.viewModels[indexPath.row].title,
                    publishedAt: self.viewModels[indexPath.row].publishedAt,
                    imageData: self.viewModels[indexPath.row].imageData ?? nil
                )
                cell.isFavorite.toggle()
                cell.setupFavoriteButton()
                
            } else {
                cell.isFavorite.toggle()
                cell.setupFavoriteButton()
                
                vc.isFavorite.toggle()
                vc.setupFavoriteButton()
                self.deleteFromFavorites(indexPath: indexPath)
            }
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        changeFavoriteStatus(indexPath: indexPath, cell: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FullNewsViewController()
        vc.configure(with: viewModels[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        
        vc.favorite = { [weak self] in
            guard let self = self else { return }
            
            if !vc.isFavorite {
                CoreDataManager.shared.createItem (
                    title: self.viewModels[indexPath.row].title,
                    publishedAt: self.viewModels[indexPath.row].publishedAt,
                    imageData: self.viewModels[indexPath.row].imageData ?? nil
                )
                vc.isFavorite.toggle()
                vc.setupFavoriteButton()
            } else {
                vc.isFavorite.toggle()
                vc.setupFavoriteButton()
                self.deleteFromFavorites(indexPath: indexPath)
            }
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        256
    }
}




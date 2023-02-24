//
//  NewsViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/19/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
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
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        
        cell.favorite = { [weak self] in
            guard let self = self else { return }
            
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
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FullNewsViewController()
        vc.configure(with: viewModels[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        256
    }
}

extension NewsViewController: UITableViewDelegate {
    
}



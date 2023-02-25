//
//  FullNewsViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/23/23.
//

import UIKit

class FullNewsViewController: UIViewController {
    
    // closure for transmitting a user action
    var favorite : (() -> Void)? = nil
    
    var isFavorite = false
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite"), for: .normal)
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "news")
        imageView.layer.cornerRadius = 22
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        title = "Статья"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(named: "NABlue")
        view.backgroundColor = UIColor(named: "NABackground")
        setupFavoriteButton()
        view.addSubview(dateLabel)
        view.addSubview(favoriteButton)
        view.addSubview(newsTitleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(newsImageView)
       
        setupConstraints()
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 260),
            
            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 9),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            
            favoriteButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 36),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            
            newsTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            newsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    // view configuration when switching from NewsViewController
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
        guard let date = viewModel.publishedAt.convertIntoDate() else { return }
        dateLabel.text = date.format("dd MMMM")
    }
    
    // view configuration when switching from FavoritesViewController
    func configureForFavorites(with viewModel: NewsTestApp) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.publishedAt
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        
        guard let date = viewModel.publishedAt?.convertIntoDate() else { return }
        dateLabel.text = date.format("dd MMMM")
    }
    
    func setupFavoriteButton() {
        isFavorite ? favoriteButton.setImage(UIImage(named: "didTapFavorite"), for: .normal) : favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
    }
    
    @objc func didTapFavorite() {
        if let buttonAction = self.favorite {
            buttonAction()
        }
    }
}


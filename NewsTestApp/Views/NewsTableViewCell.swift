//
//  NewsTableViewCell.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/22/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    // closure for transmitting a user action to NewsViewController
    var favorite : (() -> Void)? = nil
    
    var isFavorite = false
    
    private lazy var cellContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "23 февраля"
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
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor(named: "NABackground")
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(newsImageView)
        cellContainer.addSubview(dateLabel)
        cellContainer.addSubview(favoriteButton)
        cellContainer.addSubview(newsTitleLabel)
        cellContainer.addSubview(subtitleLabel)
        
        setupFavoriteButton()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cellContainer.heightAnchor.constraint(equalToConstant: 240),
            
            newsImageView.topAnchor.constraint(equalTo: cellContainer.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: cellContainer.bottomAnchor, constant: -108),
            
            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 9),
            dateLabel.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 18),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            
            favoriteButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 36),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            
            newsTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            newsTitleLabel.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 16),
            newsTitleLabel.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -16),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            subtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -16),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        dateLabel.text = nil
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    // cell configuration
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.publishedAt
        
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

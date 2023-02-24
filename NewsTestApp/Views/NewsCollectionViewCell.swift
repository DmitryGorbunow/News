//
//  NewsCollectionViewCell.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/23/23.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewsCollectionViewCell"
    
    // closure for transmitting a user action to FullNewsViewController
    var favorite : (() -> Void)? = nil
    
    var isFavorite = false
    
    private lazy var cellContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "didTapFavorite"), for: .normal)
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 22
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(newsImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(newsTitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -96),

            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 11),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),

            favoriteButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            favoriteButton.heightAnchor.constraint(equalToConstant: 26),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),

            newsTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        dateLabel.text = nil
        newsTitleLabel.text = nil
    }
    
    // cell configuration
    func configure(with viewModel: NewsTestApp) {
        newsTitleLabel.text = viewModel.title
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        guard let date = viewModel.publishedAt?.convertIntoDate() else { return }
        dateLabel.text = date.format("dd MMMM")
    }
    
    @objc func didTapFavorite() {
        if let buttonAction = self.favorite {
            buttonAction()
        }
    }
}

//
//  ArticleDetailViewController.swift
//  Headlines
//
//  Created by Nishu Nishanta on 11/03/25.
//

import Foundation
import UIKit

class ArticleDetailViewController: UIViewController {
    private let article: Article
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        return titleLabel
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
       
        return imageView
    }()
    private let subTitileLabel: UILabel = {
        let subTitle = UILabel()
        subTitle.numberOfLines = 0
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.textColor = .label
        subTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        return subTitle
    }()
    private let descriptionLabel: UILabel = {
        let descLabel = UILabel()
       
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.textColor = .label
        descLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureData()
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //set up UI
    func setUpUI () {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        [imageView, titleLabel, subTitileLabel, descriptionLabel].forEach { contentView.addSubview($0) }
        
       
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,multiplier: 9/16),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subTitileLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subTitileLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subTitileLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: subTitileLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
            
            
        ])
        
        
       
    }
    
    func configureData() {
       
        titleLabel.text = article.webTitle
        subTitileLabel.text = article.formattedPublicationDate
        descriptionLabel.text = article.description
        
        if let url = article.imageURL {
            imageView.setImage(with: url)
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
    }
}

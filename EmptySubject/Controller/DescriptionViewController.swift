//
//  DescriptionViewController.swift
//  EmptySubject
//
//  Created by Astemir Shibzuhov on 09.02.2020.
//  Copyright © 2020 Astemir Shibzuhov. All rights reserved.
//

import UIKit
import SnapKit

class DescriptionViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bitcoin")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var viewForScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
    }
    func addViews() {
        viewForScrollView.addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().offset(16)
        }
        viewForScrollView.addSubview(categoryImage)
        categoryImage.snp.makeConstraints { (make) in
            make.top.equalTo(categoryNameLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().offset(16)

        }
        viewForScrollView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryImage.snp.bottom).offset(16)
            make.leading.bottom.equalToSuperview().offset(16)
            make.width.equalTo(UIScreen.main.bounds.size.width - 32)
        }
        scrollView.addSubview(viewForScrollView)
        viewForScrollView.snp.makeConstraints { (make) in
            make.bottom.top.leading.equalTo(scrollView.contentLayoutGuide)
            make.trailing.lessThanOrEqualTo(scrollView.contentLayoutGuide).offset(16)
        }
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    
    

}

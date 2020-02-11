//
//  MainViewController.swift
//  EmptySubject
//
//  Created by Astemir Shibzuhov on 09.02.2020.
//  Copyright © 2020 Astemir Shibzuhov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, NetworkingDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mealModel: MealModel?
    let networking = Networking()
    var indexPaths: [IndexPath]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networking.delegate = self
        settingCollection()
        networking.getCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    func settingCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        
        collectionView.register(UINib(nibName: "MealCategoryCell", bundle: nil), forCellWithReuseIdentifier: "MealCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func getMealCategories(mealModel: MealModel) {
        self.mealModel = mealModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let mealModel = mealModel {
            if let catigories = mealModel.categories {
                return catigories.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealCell", for: indexPath) as! MealCategoryCell
        if let mealModel = mealModel {
            if let catigories = mealModel.categories {
                cell.viewContent.backgroundColor = .white
                cell.categoryTextLabel.text = catigories[indexPath.row].strCategory
                networking.loadImage(link: mealModel.categories![indexPath.row].strCategoryThumb!) { (image) in
                    
                    DispatchQueue.main.async {
                        cell.categoryImage.image = image
                        collectionView.reloadData()
                        
                    }
                }
                
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let descriptionVC = DescriptionViewController()
        let cell = collectionView.cellForItem(at: indexPath) as! MealCategoryCell
        descriptionVC.categoryImage.image = cell.categoryImage.image
        guard let mealModel = mealModel else {return}
        descriptionVC.categoryNameLabel.text = mealModel.categories![indexPath.row].strCategory
        descriptionVC.descriptionLabel.text = mealModel.categories![indexPath.row].strCategoryDescription
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
    
    
    
    
}

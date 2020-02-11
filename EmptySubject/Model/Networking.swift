//
//  Networking.swift
//  EmptySubject
//
//  Created by Astemir Shibzuhov on 09.02.2020.
//  Copyright © 2020 Astemir Shibzuhov. All rights reserved.
//

import UIKit
import Alamofire

protocol NetworkingDelegate {
    func getMealCategories(mealModel: MealModel)
}

class Networking {
    
    var delegate: NetworkingDelegate?
    private var mealCategoriesLink = "https://www.themealdb.com/api/json/v1/1/categories.php"
    
    func getCategories() {
        request(mealCategoriesLink).responseJSON { (response) in
            guard let delegate = self.delegate else {return}
            guard let data = response.data else {return}
            let decoder = JSONDecoder()
            do {
                let mealModel = try decoder.decode(MealModel.self, from: data)
                delegate.getMealCategories(mealModel: mealModel)
                print(mealModel.categories![0].strCategory!)
            } catch {
                let error = error as NSError
                print("Error \(error), \(error.userInfo)")
            }
        }
    }
    
    // I did a validation check and fixed rresponse data
    
    func loadImage(link: String, completion: @escaping (UIImage) -> ()) {
        request(link).validate().responseData { (response) in
            if response.result.isSuccess {
                response.result.ifSuccess {
                    guard let data = response.data else {return}
                    guard let image = UIImage(data: data) else {return}
                    completion(image)
                }
            } else if response.result.isFailure {
                response.result.ifFailure {
                    let error = response.result.error! as NSError
                    print("Error: \(error) \(error.userInfo)")
                }
            }
        }
    }
    
}

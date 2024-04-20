//
//  ViewController.swift
//  FinalProjectCodePath
//
//  Created by Nguyen Ngoc Bao on 15/04/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let recipes = ["Pasta Carbonara", "Chocolate Cake", "Chicken Stir-Fry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source
        tableView.dataSource = self
        
        // Register custom cell
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCell")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        
        // Configure the cell
        let recipeName = recipes[indexPath.row]
        cell.foodImageView.image = UIImage(named: "\(recipeName.lowercased()).jpg") // Assuming your image names are the same as recipe names
        cell.foodLabel.text = recipeName
        
        return cell
    }
}


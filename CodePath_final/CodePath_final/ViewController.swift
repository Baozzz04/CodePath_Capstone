//
//  ViewController.swift
//  CodePath_final
//
//  Created by Nguyen Ngoc Bao on 19/04/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let dishes = [("Pizza", "pizza_image"), ("Burger", "burger_image"), ("Sushi", "sushi_image")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath) as! DishTableViewCell
        
        let (name, imageName) = dishes[indexPath.row]
        cell.dishLabel.text = name
        cell.dishImage.image = UIImage(named: imageName)
        
        return cell
    }
}


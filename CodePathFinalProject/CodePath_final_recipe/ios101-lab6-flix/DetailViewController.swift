//
//  DetailViewController.swift
//  ios101-lab6-flix
//
//  Created by Nguyen Ngoc Bao on 20/04/2024.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            // 1.
            movie.addToFavorites()
        } else {
            // 2.
            movie.removeFromFavorites()
        }
    }
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterImageView.layer.cornerRadius = 20
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.borderColor = UIColor.white.cgColor
        
        favouriteButton.layer.cornerRadius = favouriteButton.frame.width / 2
        
        navigationItem.largeTitleDisplayMode = .never
        
        let favorites = Movie.getMovies(forKey: Movie.favoritesKey)
        // 2.
        if favorites.contains(movie) {
            // 3.
            favouriteButton.isSelected = true
        } else {
            // 4.
            favouriteButton.isSelected = false
        }

        // Do any additional setup after loading the view.

        titleLabel.text = movie.title
//        recipeLabel.text = "Recipe: \(movie.overview)"
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: recipeLabel.font.pointSize)
        ]
        let boldText = NSMutableAttributedString(string: "Recipe: ", attributes: boldAttributes)
        boldText.append(NSAttributedString(string: movie.overview))
        recipeLabel.attributedText = boldText

        // Unwrap the optional vote average
        if let ingredientsF = movie.ingred {

            // voteAverage is a Double
            // We can convert it to a string using `\(movie.voteAverage)` (aka *String Interpolation*)
            // inside string quotes (aka: *string literal*)
//            ingredientLabel.text = "Ingredients: \(ingredientsF)"
            
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: ingredientLabel.font.pointSize)
            ]
            let boldText = NSMutableAttributedString(string: "Ingredients: ", attributes: boldAttributes)
            boldText.append(NSAttributedString(string: ingredientsF))
            ingredientLabel.attributedText = boldText
        } else {

            // if vote average is nil, set vote average label text to empty string
            ingredientLabel.text = ""
        }
        
        if let posterPath = movie.posterPath,

        let imageUrl = URL(string: posterPath) {
            Nuke.loadImage(with: imageUrl, into: posterImageView)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

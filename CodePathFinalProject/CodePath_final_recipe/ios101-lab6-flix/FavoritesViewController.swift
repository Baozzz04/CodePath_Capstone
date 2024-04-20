//
//  FavoritesViewController.swift
//  ios101-lab6-flix
//
//  Created by Nguyen Ngoc Bao on 20/04/2024.
//

import UIKit
import Nuke

class FavoritesViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    var favoriteMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Anything in the defer call is guaranteed to happen last
        defer {
            // Show the "Empty Favorites" label if there are no favorite movies
            emptyFavoritesLabel.isHidden = !favoriteMovies.isEmpty
        }

        // TODO: Get favorite movies and display in table view
        let movies = Movie.getMovies(forKey: Movie.favoritesKey)
        // 2.
        self.favoriteMovies = movies
        // 3.
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = favoriteMovies[indexPath.row]
        
        if let posterPath = movie.posterPath,
           let imageUrl = URL(string: posterPath) {
           Nuke.loadImage(with: imageUrl, into: cell.posterImageView)
        }
        
        cell.titleLabel.text = movie.title
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // MARK: - Pass the selected movie to the Detail View Controller

        // Get the index path for the selected row.
        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedMovie = favoriteMovies[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.movie = selectedMovie
    }

}

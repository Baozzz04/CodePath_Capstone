//
//  Movie.swift
//  ios101-lab6-flix
//

import Foundation

struct MovieFeed: Decodable {
    let results: [Movie]
}

struct Movie: Codable, Equatable {
    //overview = recipe
    //ingred = ingreds
    var title: String
    var overview: String
    var posterPath: String? // Path used to create a URL to fetch the poster image

    // MARK: Additional properties for detail view
    let backdropPath: String? // Path used to create a URL to fetch the backdrop image
    var ingred: String?
    let voteAverage: Double?
    let releaseDate: Date?

    // MARK: Custom coding keys
    // Allows us to map the property keys returned from the API that use underscores (i.e. `poster_path`)
    // to a more "swifty" lowerCamelCase naming (i.e. `posterPath` and `backdropPath`)
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case ingred = "ingredients"
    }
}

extension Movie {
    static var favoritesKey: String {
        return "Favorites"
    }
    
    static func save(_ movies: [Movie], forKey key: String) {
        // 1.
        let defaults = UserDefaults.standard
        // 2.
        let encodedData = try! JSONEncoder().encode(movies)
        // 3.
        defaults.set(encodedData, forKey: key)
    }
    
    static func getMovies(forKey key: String) -> [Movie] {
        // 1.
        let defaults = UserDefaults.standard
        // 2.
        if let data = defaults.data(forKey: key) {
            // 3.
            let decodedMovies = try! JSONDecoder().decode([Movie].self, from: data)
            // 4.
            return decodedMovies
        } else {
            // 5.
            return []
        }
    }
        
    func addToFavorites() {
        // 1.
        var favoriteMovies = Movie.getMovies(forKey: Movie.favoritesKey)
        // 2.
        favoriteMovies.append(self)
        // 3.
        Movie.save(favoriteMovies, forKey: Movie.favoritesKey)
    }

    // Removes the movie from the favorites array in UserDefaults
    // 1. Get all favorite movies from UserDefaults
    // 2. remove all movies from the array that match the movie instance this method is being called on (i.e. `self`)
    //   - The `removeAll` method iterates through each movie in the array and passes the movie into a closure where it can be used to determine if it should be removed from the array.
    // 3. If a given movie passed into the closure is equal to `self` (i.e. the movie calling the method) we want to remove it. Returning a `Bool` of `true` removes the given movie.
    // 4. Save the updated favorite movies array.
    func removeFromFavorites() {
        // 1.
        var favoriteMovies = Movie.getMovies(forKey: Movie.favoritesKey)
        // 2.
        favoriteMovies.removeAll { movie in
            // 3.
            return self == movie
        }
        // 4.
        Movie.save(favoriteMovies, forKey: Movie.favoritesKey)
    }
}

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var movies: [Movie] = [] // Empty array for now
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Hardcoded movie data
        let hardcodedMovies = [
            Movie(title: "Savory Stuffed Bell Peppers", overview: "This recipe features vibrant bell peppers filled with a savory mixture of ground beef, rice, onions, and spices, all simmered in a flavorful tomato sauce. Topped with gooey melted cheese, these stuffed peppers are a hearty and comforting meal perfect for any occasion.", posterPath: "https://www.northforkbison.com/wp-content/uploads/2022/05/suffed-peppers-northfork-recipe.jpg", backdropPath: "path_to_backdrop_image", ingred: "You'll need 4 large bell peppers (any color), 1 pound (450g) lean ground beef, 1 cup cooked rice, 1 onion diced, 2 cloves garlic minced, 1 can (14 ounces) diced tomatoes, 1 teaspoon dried oregano, 1 teaspoon dried basil, salt and pepper to taste, and 1 cup shredded cheese (such as mozzarella or cheddar) for topping.", voteAverage: 9.3, releaseDate: Date()),
            Movie(title: "Mango Coconut Chicken Curry", overview: "Indulge in the exotic flavors of this tantalizing mango coconut chicken curry. Tender chunks of chicken breast are simmered in a rich and creamy coconut milk sauce infused with aromatic spices, tangy mango, and fresh herbs. Serve over steamed rice for a satisfying and aromatic dish that will transport your taste buds to tropical paradise.", posterPath: "https://img.taste.com.au/OtwRbb61/taste/2016/11/mango-chicken-curry-102913-1.jpeg", backdropPath: "path_to_backdrop_image", ingred: "Gather 1 pound (450g) boneless, skinless chicken breasts cut into chunks, 1 tablespoon vegetable oil, 1 onion finely chopped, 3 cloves garlic minced, 1 tablespoon ginger grated, 1 red bell pepper sliced, 1 cup mango chunks (fresh or frozen), 1 can (13.5 ounces) coconut milk, 2 tablespoons curry powder, 1 teaspoon ground turmeric, salt and pepper to taste, fresh cilantro for garnish, and cooked rice for serving.", voteAverage: 9.2, releaseDate: Date()),
            Movie(title: "Lemon Herb Roasted Salmon", overview: "Elevate your dinner with this elegant yet effortless lemon herb roasted salmon. Fresh salmon fillets are marinated in a zesty blend of lemon juice, garlic, and herbs, then roasted to perfection until flaky and tender. Serve alongside roasted vegetables for a light and healthy meal bursting with bright, citrusy flavors.", posterPath: "https://sallysbakingaddiction.com/wp-content/uploads/2015/09/healthy-lemon-herb-salmon.jpg", backdropPath: "path_to_backdrop_image", ingred: "For this dish, you'll need 4 salmon fillets (6 ounces each), 2 tablespoons olive oil, 2 cloves garlic minced, 1 lemon zest and juice, 1 teaspoon dried oregano, 1 teaspoon dried thyme, salt and pepper to taste, lemon slices for garnish, and fresh parsley for garnish.", voteAverage: 9.0, releaseDate: Date()),
            Movie(title: "Vegetarian Quinoa Stuffed Portobello Mushrooms", overview: "These hearty vegetarian quinoa stuffed portobello mushrooms are a delicious and nutritious way to enjoy a meatless meal. Juicy portobello mushrooms are filled with a flavorful mixture of quinoa, spinach, sun-dried tomatoes, and feta cheese, then baked until golden and bubbling. Packed with protein and fiber, these stuffed mushrooms are sure to satisfy even the heartiest appetites.", posterPath: "https://minimalistbaker.com/wp-content/uploads/2017/07/DELICIOUS-Vegetable-Quinoa-Stuffed-Portobello-Mushrooms-30-min-healthy-SO-satisfying-vegan-glutenfree-plantbased-vegetables-recipes-minimalistbaker.jpg", backdropPath: "path_to_backdrop_image", ingred: "Get ready with 4 large portobello mushrooms, 1 cup quinoa rinsed, 2 cups vegetable broth, 1 tablespoon olive oil, 1 onion finely chopped, 2 cloves garlic minced, 2 cups fresh spinach chopped, 1/4 cup sun-dried tomatoes chopped, 1/4 cup crumbled feta cheese, salt and pepper to taste, and fresh parsley for garnish. These ingredients will make a delicious and satisfying meal for each recipe.", voteAverage: 9.0, releaseDate: Date()),
        ]
        
        // Assign hardcoded movies to the movies array
        movies = hardcodedMovies
        
        // Reload table view data
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // get the index path for the selected row
        if let selectedIndexPath = tableView.indexPathForSelectedRow {

            // Deselect the currently selected row
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedMovie = movies[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.movie = selectedMovie
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        if let posterPath = movie.posterPath,
           let imageUrl = URL(string: posterPath) {
           Nuke.loadImage(with: imageUrl, into: cell.posterImageView)
        }
        
        cell.titleLabel.text = movie.title
        
        return cell
    }
}

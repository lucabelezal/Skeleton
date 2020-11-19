import Networking

protocol MovieListViewModelProtocol {
    var isToReloadTableView: Bool { get }
    var totalCount: Int { get }
    var currentCount: Int { get }
    var movieModel: (_ index: Int) -> MovieCellViewModelProtocol { get }
    var indexPathsToReload: [IndexPath]? { get }
    var service: MovieServiceProtocol? { get }
}

struct MovieListViewModel: MovieListViewModelProtocol {

    var service: MovieServiceProtocol?

    var isToReloadTableView: Bool
    var totalCount: Int
    var currentCount: Int
    var movieModel: (Int) -> MovieCellViewModelProtocol
    var indexPathsToReload: [IndexPath]?

    init() {
        self.isToReloadTableView = false
        self.totalCount = 5
        self.currentCount = 5
        self.movieModel = { _ in return MovieCellViewModel() }
    }
    
    init(with data: PopularMovies, and movies: [Movie], isToReloadTableView: Bool, service: MovieServiceProtocol?) {
        self.isToReloadTableView = isToReloadTableView
        self.totalCount = data.totalResults
        self.currentCount = movies.count
        self.service = service

        self.movieModel = { MovieCellViewModel(movie: movies[$0]) }
        
        if data.page > 1 {
            indexPathsToReload = MovieListViewModel.calculateIndexPathsToReload(from: data.movies, with: movies)
        }
    }
    
    private static func calculateIndexPathsToReload(from newMovies: [Movie], with allMovies: [Movie]) -> [IndexPath] {
        let startIndex = allMovies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

class ImageLoader {

  private static let cache = NSCache<NSString, NSData>()

  class func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> Void) {

    DispatchQueue.global(qos: .background).async {

      if let data = self.cache.object(forKey: url.absoluteString as NSString) {
        DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        return
      }

      guard let data = NSData(contentsOf: url) else {
        DispatchQueue.main.async { completionHandler(nil) }
        return
      }

      self.cache.setObject(data, forKey: url.absoluteString as NSString)
      DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
    }
  }
}

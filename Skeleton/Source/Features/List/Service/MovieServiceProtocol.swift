import Networking

protocol MovieServiceProtocol: class {
    func popularMovies(page: Int, isRequestCanceled: Bool, completion: @escaping (Result<PopularMovies>) -> Void)
    func loadImage(with path: String, completion: @escaping (UIImage) -> Void)
}

import UIKit

class DataTask<T: Decodable>: AsyncTask {

    private (set) var url: URL
    var result: T?
    required init(_ page: Int, url: URL) {
        self.url = url
        super.init("\(page)")
    }

    override func execute() {

        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let photos = try? JSONDecoder().decode(T.self, from: data) else {
                self.finish(true)
                return
            }
            self.result = photos
            self.finish(true)
        }
        dataTask.resume()
    }
}

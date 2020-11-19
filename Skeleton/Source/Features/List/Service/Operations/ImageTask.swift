import UIKit

enum HTTPCode: Int {
    case success = 200
}

enum ImageResult {
    case success(image: UIImage, imageUrl: URL, indexPath: IndexPath)
    case error(error: Error?, indexPath: IndexPath)
}

class ImageTask: AsyncTask {

    let imageUrl: URL
    var result: ImageResult?
    let indexPath: IndexPath

    required init(url: URL, indexPath: IndexPath) {
        self.imageUrl = url
        self.indexPath = indexPath
        super.init(imageUrl.absoluteString)
    }

    override func execute() {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: self.imageUrl) {(location, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode == HTTPCode.success.rawValue,
                let path = location, let data = try? Data(contentsOf: path), let image = UIImage(data: data) {

                self.result = ImageResult.success(image: image, imageUrl: self.imageUrl, indexPath: self.indexPath)
                
            } else {
                self.result = ImageResult.error(error: error, indexPath: self.indexPath)
            }
            self.finish(true)
        }
        downloadTask.resume()
    }

}

import Foundation

public extension String {
    var toURL: URL? {
        return URL(string: self)
    }

    func formattedDateFromString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            return dateFormatter.string(from: date)
        }

        return nil
    }
}

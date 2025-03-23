import UIKit

extension UIImageView {
    func setImage(with url: URL?) {
        guard let url else {
            self.image = nil
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

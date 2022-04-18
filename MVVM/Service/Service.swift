//
//  Service.swift
//  MVVM
//
//  Created by Aneri Parikh on 14/04/22.
//

import Foundation
import UIKit

protocol ServiceLayer {
    func fetchDemoData(url: String, completion: @escaping (Demo?, String?) -> ())
}

class Service: ServiceLayer {
    func fetchDemoData(url: String, completion: @escaping (Demo?, String?) -> ()) {
        guard let url = URL(string: url) else {
            completion(nil, "No URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error?.localizedDescription)
                return
            }

            if let resp = try? JSONDecoder().decode(Demo.self, from: data) {
                completion(resp, nil)
            } else {
                completion(nil, "Error")
            }
        }.resume()
    }
}

extension UIImageView {
    private func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}

//
//  CatCollectionViewCell.swift
//  CatApp
//
//  Created by Henrique Lima on 25/11/19.
//  Copyright © 2019 Henrique Lima. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {

    @IBOutlet var catImageView: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    // Cache for downloaded images ( TODO: treat race condition (thread safety?) )
    static var imageCache: [String: UIImage] = [:]
    static let reuseIdentifier = "CatCell"
    
    var task: URLSessionDataTask?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        catImageView.layer.cornerRadius = 5
        catImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        task?.cancel()
        catImageView.image = nil
    }
    
    func configure(with imageURL: URL) {
        indicator.startAnimating()
        // Check if image is in cache first
        if let image = Self.imageCache[imageURL.lastPathComponent] {
            catImageView.image = image
            indicator.stopAnimating()
        } else {
            fetchImage(url: imageURL)
        }
    }
    
    private func fetchImage(url: URL) {
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.catImageView.image = downloadedImage
                self?.indicator.stopAnimating()
                // Save image to cache
                Self.imageCache[url.lastPathComponent] = downloadedImage
            }
        }
        task?.resume()
    }
}

//
//  ViewController.swift
//  CatApp
//
//  Created by Henrique Lima on 25/11/19.
//  Copyright © 2019 Henrique Lima. All rights reserved.
//

import UIKit

class CatListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var adapter: CatListAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CatApp"
        adapter = CatListAdapter(collectionView: collectionView)
        fetchCats()
    }
    
    private func fetchCats() {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/search/?q=cats") else { return }
        var request = URLRequest(url: url)
        request.setValue("Client-ID 1ceddedc03a5d71", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let content = data else { return }
            do {
                let decoder = JSONDecoder()
                let catResponse = try decoder.decode(CatResponse.self, from: content)
                DispatchQueue.main.async {
                    let images = catResponse.data.compactMap { $0.images }
                    // Get URL from Strings, ignore if can't parse
                    let urls = images.flatMap {$0.compactMap { URL(string: $0.link)}}
                    // Only consider jpg and png files
                    let filteredUrls = urls.filter { $0.lastPathComponent.hasSuffix(".jpg") || $0.lastPathComponent.hasSuffix(".png")
                    }
                    self.adapter.setData(filteredUrls)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}


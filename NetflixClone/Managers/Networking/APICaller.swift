//
//  APICaller.swift
//  NetflixClone
//
//  Created by Родион Холодов on 31.07.2025.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func getPopularMovies(completion: @escaping(Result<[Title], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/movie/popular"
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(NetworkConstants().authToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                    completion(.success(results.results))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            }.resume()
        }
    }
}

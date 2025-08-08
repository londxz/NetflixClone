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
    
    func searchMovies(completion: @escaping(Result<[Title], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/search/movie?query=war&include_adult=true&language=en-US&page=1"
        
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
    
    func getMovie(with query: String, completion: @escaping(Result<String, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "youtube.googleapis.com"
        urlComponents.path = "/youtube/v3/search"
        let queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "key", value: NetworkConstants().youtubeApiKey)
        ]
        urlComponents.queryItems = queryItems
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(results)
                    return
                } catch {
                    print(error)
                    completion(.failure(error))
                    return
                }
            }.resume()
        }
    }
}

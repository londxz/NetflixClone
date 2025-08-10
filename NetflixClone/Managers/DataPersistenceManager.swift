//
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by Родион Холодов on 10.08.2025.
//

import Foundation
import UIKit
import CoreData

struct DataPersistenceManager {
    
    enum DataError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    func downloadTitleWith(model: Title, completion: @escaping(Result<Void, DataError>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        item.id = Int64(model.id)
        item.originalTitle = model.originalTitle
        item.title = model.title
        item.overview = model.overview
        item.voteAverage = model.voteAverage
        item.popularity = model.popularity
        item.releaseDate = model.releaseDate
        item.posterPath = model.posterPath
        
        do {
            try context.save()
            completion(.success(()))
            return
        } catch {
            completion(.failure(DataError.failedToSaveData))
            return
        }
    }
    
    func fetchTitles(completion: @escaping(Result<[TitleItem], DataError>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem> = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
            return
        } catch {
            completion(.failure(DataError.failedToFetchData))
            return
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping(Result<Void, DataError>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
            return
        } catch {
            completion(.failure(DataError.failedToDeleteData))
        }
    }
}

//
//  DataStore.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 11/12/21.
//

import Foundation
import CoreData

class DataBaseManager: NSObject {
    
    private let coreDataManager = CoreDataUtil.shared()
    private var apiServices: APIService
    
    init (apiServices: APIService = APIService()) {
        self.apiServices = apiServices
    }
    
    func saveMovieToDb(typeCategory: TypeCategory, completionBlock : @escaping ()->()) {
        apiServices.downloadMovies(typeCategory: typeCategory, completion: { [weak self] success, model in
            if success, let movies = model {
                self?.deleteMoviesFromDb(typeCategory: typeCategory)
                self?.coreDataManager.prepare(typeCategory: typeCategory, dataForSaving: movies.results)
            }
            completionBlock()
        })
    }
    
    func deleteMoviesFromDb(typeCategory: TypeCategory) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: "Movie")
        
        let predicate = NSPredicate(format: "type == %@", String(typeCategory.rawValue))
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //deleteRequest.resultType = .resultTypeObjectIDs
        
        let context = self.coreDataManager.managedObjectContext
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error al eliminar")
        }
    }
    
    func loadMoviesFromDb(typeCategory: TypeCategory) -> [MovieItem] {
        let fetchRequest = Movie.fetchRequest()
        let predicate = NSPredicate(format: "type == %@", String(typeCategory.rawValue))
        fetchRequest.predicate = predicate
        
        let context = self.coreDataManager.managedObjectContext
        var viewModelArray = [MovieItem]()
        do {
            let movies: [Movie] = try context.fetch(fetchRequest)
            if movies.count > 0 {
                for movie in movies {
                    let viewModel = MovieItem(data: movie)
                    viewModelArray.append(viewModel!)
                }
            }
        } catch {
            print("Error fetching data from CoreData")
        }
        return viewModelArray
    }
    
}

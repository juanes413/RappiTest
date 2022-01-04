//
//  MockSearchViewModel.swift
//  Test MLTests
//
//  Created by Juan Esteban Pelaez on 17/11/21.
//

import Foundation
import CoreData
@testable import RappiTest

class MockDataBaseManager: DataBaseManager {
    
    override init (apiServices: APIService = APIService(), coreDataManager: CoreDataUtil = CoreDataUtil.shared()) {
        super.init(apiServices: apiServices, coreDataManager: coreDataManager)
    }
    
    override func saveMovieToDb(typeCategory: TypeCategory, completionBlock : @escaping ()->()) {
        
        var movies = [MovieItem]()
        if let movie = MovieItem(backdropPath: "", id: 0, overview: "Description", posterPath: "/2jVVDtDaeMxmcvrz2SNyhMcYtWc.jpg", releaseDate: "2021-12-01", title: "Encanto", voteAverage: 5.5) {
            movies.append(movie)
        }
        
        if let movie2 = MovieItem(backdropPath: "", id: 2, overview: "Description", posterPath: "/odBUpjZGxY3y7FBo5NBtEYGJf5r.jpg", releaseDate: "2021-12-01", title: "Spiderman no way home", voteAverage: 8.5) {
            
            movies.append(movie2)
        }
        
        self.deleteMoviesFromDb(typeCategory: typeCategory)
        self.coreDataManager.prepare(typeCategory: typeCategory, dataForSaving: movies)
        completionBlock()
    }
    
    override func deleteMoviesFromDb(typeCategory: TypeCategory) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: "Movie")
        
        let predicate = NSPredicate(format: "type == %@", String(typeCategory.rawValue))
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let context = self.coreDataManager.managedObjectContext
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error al eliminar")
        }
    }
    
    override func loadMoviesFromDb(typeCategory: TypeCategory) -> [MovieItem] {
        let fetchRequest = Movie.fetchRequest()
        let predicate = NSPredicate(format: "type == %@", String(typeCategory.rawValue))
        fetchRequest.predicate = predicate
        
        let context = self.coreDataManager.managedObjectContext
        var viewModelArray = [MovieItem]()
        do {
            let movies: [Movie] = try context.fetch(fetchRequest)
            if movies.count > 0 {
                for movie in movies {
                    if let viewModel = MovieItem(data: movie) {
                        viewModelArray.append(viewModel)
                    }
                }
            }
        } catch {
            print("Error fetching data from CoreData")
        }
        return viewModelArray
    }
    
}


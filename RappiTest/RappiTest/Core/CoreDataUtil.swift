//
//  CoreDataUtil.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 10/12/21.
//

import Foundation
import CoreData

class CoreDataUtil: NSObject {
    
    // MARK: - Core Data
    
    private override init() {}
    
    // Create a shared Instance
    static let _shared = CoreDataUtil()
    
    // Shared Function
    class func shared() -> CoreDataUtil {
        return _shared
    }
    
    lazy var managedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    // MARK: - Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "RappiTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func prepare(typeCategory: TypeCategory, dataForSaving: [MovieItem]){
        // loop through all the data received from the Web and then convert to managed object and save them
        _ = dataForSaving.map{ self.createEntityFrom(typeCategory: typeCategory, movieItem: $0) }
        self.saveContext()
    }
    
    private func createEntityFrom(typeCategory: TypeCategory, movieItem: MovieItem) -> Movie {
        
        // Convert
        let movie = Movie(context: self.managedObjectContext)
        movie.type = Int16(typeCategory.rawValue)
        movie.id = movieItem.id
        movie.title = movieItem.title
        movie.posterPath = movieItem.posterPath
        movie.overview = movieItem.overview
        movie.voteAverage = movieItem.voteAverage
        movie.releaseDate = movieItem.releaseDate
        movie.backdropPath = movieItem.backdropPath
        
        return movie
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

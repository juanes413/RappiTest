//
//  Movie+CoreDataProperties.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 10/12/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var overview: String?
    @NSManaged public var type: Int16
    @NSManaged public var posterPath: String?

}

extension Movie : Identifiable {

}

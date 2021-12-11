//
//  TypeCategory.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 9/12/21.
//

protocol NameCategory {
    var name: String { get }
}

enum TypeCategory: Int, NameCategory {
    case popular
    case topRated
    case upcoming
    
    var name: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

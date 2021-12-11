//
//  MovieViewModel.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 10/12/21.
//
import Foundation

class MovieViewModel {
    
    var viewModelToViewBinding: MovieViewModelToViewBinding?
    private var apiServices: APIService
    
    init(viewModelToViewBinding: MovieViewModelToViewBinding, apiServices:APIService = APIService()) {
        self.viewModelToViewBinding = viewModelToViewBinding
        self.apiServices = apiServices
    }
    
    //Invocar servicio api para el buscador
    func loadMoviesFromService(typeCategory: TypeCategory) {
        apiServices.downloadMovies(typeCategory: typeCategory, completion: { [weak self] success, model in
            if success, let movies = model {
                self?.viewModelToViewBinding?.serviceMovieResult(typeCategory: typeCategory, results: movies.results)
            } else {
                self?.viewModelToViewBinding?.serviceError()
            }
        })
    }
        
}
// MARK: - Protocols
protocol MovieViewModelToViewBinding: AnyObject {
    func serviceMovieResult(typeCategory: TypeCategory, results: [MovieItem])
    func serviceError()
}
//Extension para volver los metodos abstractos e invocar solo los necesarios para cada vista o experiencia
extension MovieViewModelToViewBinding {
    func serviceMovieResult(typeCategory: TypeCategory, results: [MovieItem]){}
    func serviceError(){}
}


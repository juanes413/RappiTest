//
//  ApiSearch.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 15/11/21.
//
import Foundation

class APIService {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "/?language=es-ES&api_key=b4d9dac06b1d32ac32c940bf4d4ff55a"
    static let baseUrlImage = "https://image.tmdb.org/t/p/w500"
    
    private let session: URLSession
    
    // By using a default argument (in this case .shared) we can add dependency
    // injection without making our app code more complicated.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //Invocacion del servicio de busqueda
    func downloadMovies(typeCategory: TypeCategory, completion: @escaping (_ success: Bool, _ results: ResultMovie?) -> ()) {
        
        guard let url = URL(string: getUrl(typeCategory: typeCategory)) else {
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            do {//Mapear el resultado del servicio al objeto minimo requerido para esta prueba
                let model = try JSONDecoder().decode(ResultMovie.self, from: data)
                completion(true, model)
            } catch {
                completion(false, nil)
            }
            
        }
        task.resume()
    }
    
    private func getUrl(typeCategory: TypeCategory) -> String {
        
        var method = ""
        
        switch typeCategory {
        case .popular:
            method = "popular"
        case .topRated:
            method = "top_rated"
        case .upcoming:
            method = "upcoming"
        }
        
        return (APIService.baseUrl + method + APIService.apiKey)
    }
    
}

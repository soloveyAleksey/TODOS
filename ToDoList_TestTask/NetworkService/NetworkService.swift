//
//  NetworkService.swift
//  ToDoList_TestTask

import Foundation

protocol NetworkServiceProtocol {
    func getListTasks(from url: String, completion: @escaping (Result<TaskList, Error>) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session = URLSession.shared
    
    func getListTasks(from url: String, completion: @escaping (Result<TaskList, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                catchFailure(with: error)
                return
            }

            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let list = try decoder.decode(TaskList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(list))
                }
            } catch {
                catchFailure(with: error)
            }
        }
        .resume()
        
        func catchFailure(with error: Error) {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}

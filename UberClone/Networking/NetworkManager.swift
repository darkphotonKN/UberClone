//
//  NetworkManager.swift
//  UberClone
//
//  Created by Kranti on 2024/5/6.
//

import Foundation

// Custom error types to handle various scenarios
enum NetworkError: Error {
    case urlError
    case decodingError(String)
    case serverError(String)
    case unknownError
}

// API Error
struct ApiError: Decodable, Error {
    let statusCode: Int
    let message: String
    let error: String
}

class NetworkManager {
    // instantiate singleton instance
    static var shared = NetworkManager()
    
    
    // MARK: - GET REQUEST HELPER
    func getRequest<T: Decodable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        // convert url endpoint to URL object
        guard let urlObject = URL(string: "http://\(apiDomain):3000\(url)") else { return }
        
        
        // start data task for GET request with URL object
        let task = URLSession.shared.dataTask(with: urlObject) { data, response, error in
            if let error = error {
                print("DEBUG: Error occured during GET request.")
                completion(.failure(error))
                return
            }
            // check for valid data
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                do {
                    // attempt to decode the data
                    let data = try JSONDecoder().decode(T.self, from: data)
                    
                    // return data after asynchronous operation
                    completion(.success(data))
                } catch {
                    print("DEBUG: Error occued while decoding JSON data.")
                }
            }
        }
        
        // initiate async request
        task.resume()
        
    }
    
 
    // MARK: - POST REQUEST HELPER
    func postRequest<T: Encodable, U: Decodable>(url: String, payload: T, completion: @escaping (Result<U, Error>) -> Void) {
        
        // guard against any unaccepted url strings and create URL object
        guard let url = URL(string: "http://\(apiDomain):\(PORT)\(url)") else { return }

        
        // create a URLRequest object
        var request = URLRequest(url: url)
        
        // set http method to POST
        request.httpMethod = "POST"
            
        // set Content-Type headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // attempt to encode JSON
        do {
            let jsonData = try JSONEncoder().encode(payload)
            print("[postRequest helper] encoded jsonData: \(jsonData)")
            request.httpBody = jsonData // set body of request with json data
        
        } catch {
            print("DEBUG error when encoding: \(error)")
            completion(.failure(error))
        }
        
        // make post request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknownError))
                return
            }
            
            // check for errors
            if let error = error  {
                print("DEBUG error when making request: \(error)")
                completion(.failure(error))
                return
            }
            
            // attempt to unwrap data, guarding against nil data
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was nil."])))
                return
            }
            
            // use the http status code to determine whether or not completion was a success
            switch httpResponse.statusCode {
            case 200, 201:
                // do-catch in attempt to decode data
                do {
                    let responseData = try JSONDecoder().decode(U.self, from: data)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(NetworkError.decodingError("Error decoding successful response")))
                }
            default:
                do {
                    let errorData = try JSONDecoder().decode(ApiError.self, from: data)
                    completion(.failure(NetworkError.serverError(errorData.message)))
                } catch {
                    completion(.failure(NetworkError.decodingError("Error decoding error response")))
                }
            }
        }
        
        // initialize task
        task.resume()
    }
    
    // MARK: DELETE REQUEST HELPER
    func deleteRequest(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        print("Delete request with: \(url)")
        
        // guard against any unaccepted url strings and create URL object
        guard let url = URL(string: "http://\(apiDomain):3000\(url)") else { return }
        
        // create a URLRequest object
        var request = URLRequest(url: url)
        
        // set http method to POST
        request.httpMethod = "DELETE"
            
        // set Content-Type headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // make post request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for errors
            if let error = error  {
                completion(.failure(error))
                return
            }
            // check for any data response
            if let data = data {
                completion(.success(data))
            }
        }
        
        // initialize task
        task.resume()
                
    }
}

//
//  Manager.swift
//  RadioAgain
//
//  Created by Keval Patel on 11/18/20.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa
protocol Manager {}

//class RadioManagementProvider: Manager{}
enum URLString: String{
    case url = "https://raw.githubusercontent.com/jvanaria/jvanaria.github.io/master/channels.json"
    case another = "https://jsonplaceholder.typicode.com/posts"
}

enum ResponseConstants: String{
    case channels
}

class RadioManager {
    private let networkService = NetworkService()
    static let shared = RadioManager()
    func getChannels() -> Observable<[Channel]> {
        guard let url = URL(string: URLString.url.rawValue) else {
            fatalError("Failed to build url")
        }
        return networkService.fetch(url: url)
    }
}

class NetworkService {
    func fetch<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data else {
                    return
                }
                do {
                    let decode = try JSONDecoder().decode([String:T].self, from: data)
                    guard let channels = decode[ResponseConstants.channels.rawValue] else {
                        return
                    }
                    observer.onNext(channels)
                    observer.onCompleted()
                }
                catch let jsonError{
                    print(jsonError)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

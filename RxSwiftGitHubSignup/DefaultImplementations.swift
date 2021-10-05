//
//  DefaultImplementations.swift
//  RxSwiftGitHubSignup
//
//  Created by 石川大輔 on 2021/10/04.
//

import Foundation
import RxSwift

protocol GitHubValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult
}

class GitHubDefaultValidationService: GitHubValidationService {
    
    let API: GitHubAPI
    
    static let sharedValidationService = GitHubDefaultValidationService(API: GitHubDefaultAPI.sharedAPI)
    
    init(API: GitHubAPI) {
        self.API = API
    }
    
    let minPasswordCount = 5
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.isEmpty {
            return .just(.empty)
        }
        
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "Username can only contain numbers or digits"))
        }
        
        let loadingValue = ValidationResult.validating
        
        return API
            .usernameAvailable(username)
            .map { available in
                if available {
                    return .ok(message: "Username available")
                } else {
                    return .failed(message: "Username already taken")
                }
            }
            .startWith(loadingValue)
    }
    

    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "Password must be at least \(minPasswordCount) characters")
        }
        
        return .ok(message: "password acceptable")
        
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        
        if repeatedPassword.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            return .ok(message: "Password repeated")
        } else {
            return .failed(message: "Password different")
        }
        
    }
    
}


class GitHubDefaultAPI: GitHubAPI {
    
    let URLSession: Foundation.URLSession
    
    static let sharedAPI = GitHubDefaultAPI(URLSession: Foundation.URLSession.shared)
    
    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return self.URLSession.rx.response(request: request)
            .map { pair in
                pair.response.statusCode == 404
            }
            .catchAndReturn(false)
    }
    
//    func signup(_ username: String, password: String) -> Observable<Bool> {
//        // this is also just a mock
//        let signupResult = arc4random() % 5 == 0 ? false : true
//
//        return Observable.just(signupResult)
//            .delay(.seconds(1), scheduler: MainScheduler.instance)
//    }
    
}

//
//  Protocols.swift
//  RxSwiftGitHubSignup
//
//  Created by 石川大輔 on 2021/10/04.
//

import Foundation
import RxSwift

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

extension String {
    var URLEscaped: String {
       return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

protocol GitHubAPI {
    func usernameAvailable(_ username: String) -> Observable<Bool>
//    func signup(_ username: String, password: String) -> Observable<Bool>
}

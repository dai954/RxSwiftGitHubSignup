//
//  GitHubSignupViewModel.swift
//  RxSwiftGitHubSignup
//
//  Created by 石川大輔 on 2021/10/04.
//

import Foundation
import RxSwift
import RxCocoa

class GitHubSignupViewModel {
    
    let validatedUserName: Observable<ValidationResult>
    let validatedPassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    
    init(input: (
            usernaame: Observable<String>,
            password: Observable<String>,
            repeatedPassword: Observable<String>),
         dependency: (
            API: GitHubAPI,
            validationService: GitHubValidationService
         )
    ) {
        
//        let API = dependency.API
        let validationService = dependency.validationService
        
        validatedUserName = input.usernaame
            .flatMapLatest { username in
                return validationService.validateUsername(username)
                    .observe(on: MainScheduler.instance)
                    .catchAndReturn(.failed(message: "Error contacting server"))
            }
            .share(replay: 1)
        
        validatedPassword = input.password
            .map({ password in
                return validationService.validatePassword(password)
            })
            .share(replay: 1)
        
        validatedPasswordRepeated = Observable.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword(_:repeatedPassword:))
            .share(replay: 1)
        
    }
    
}

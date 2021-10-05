//
//  GitHubSignupViewController.swift
//  RxSwiftGitHubSignup
//
//  Created by 石川大輔 on 2021/10/04.
//


//   ユーザ名文字列
//    • 未入力ではない
//    • アルファベットと数字しか含まない
//   パスワード文字列は
//    • 未入力ではない
//    • 5 文字以上
//   パスワード確認文字列は
//    • 未入力ではない
//    • パスワード文字列と同じ

import Foundation

import UIKit
import RxSwift
import RxCocoa

class GitHubSignupViewController: UIViewController {

//    @IBOutlet weak var signingUpOulet: UIActivityIndicatorView!

    let usernameOutlet: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let usernameValidationOutlet: UILabel = {
        let label = UILabel()
        label.text = "name validation"
        label.textColor = .red
        return label
    }()
    
    let passwordOutlet: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordValidationOutlet: UILabel = {
        let label = UILabel()
        label.text = "password validation"
        label.textColor = .red
        return label
    }()
    
    let repeatedPasswordOutlet: UITextField = {
        let textField = UITextField()
        textField.placeholder = "RepeatedPassword"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let repeatedPasswordValidationOutlet: UILabel = {
        let label = UILabel()
        label.text = "repeated password validation"
        label.textColor = .red
        return label
    }()
    
    let signupOutlet: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
        let viewModel = GitHubSignupViewModel(
            input: (
                usernaame: usernameOutlet.rx.text.orEmpty.asObservable(),
                password: passwordOutlet.rx.text.orEmpty.asObservable(),
                repeatedPassword: repeatedPasswordOutlet.rx.text.orEmpty.asObservable()
            ),
            dependency: (
                API: GitHubDefaultAPI.sharedAPI,
                validationService: GitHubDefaultValidationService.sharedValidationService)
        )
        

//        let a = usernameValidationOutlet.rx.text
//        let b = viewModel.validatedPassword
//        let c = usernameOutlet.rx.text.orEmpty
//        let d = passwordValidationOutlet.rx.validationResult
        
        
//        viewModel.validatedUserName
//            .map({ result in
//                result.description
//            })
//            .bind(to: usernameValidationOutlet.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.validatedUserName
//            .map { result in
//                result.textColor
//            }
//            .bind(to: usernameValidationOutlet.rx.textColor)
//            .disposed(by: disposeBag)
        
        viewModel.validatedUserName
            .bind(to: usernameValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPassword
            .bind(to: passwordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPasswordRepeated
            .bind(to: repeatedPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        
    }

    

    fileprivate func setupView() {
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(usernameOutlet)
        view.addSubview(usernameValidationOutlet)
        view.addSubview(passwordOutlet)
        view.addSubview(passwordValidationOutlet)
        view.addSubview(repeatedPasswordOutlet)
        view.addSubview(repeatedPasswordValidationOutlet)
        view.addSubview(signupOutlet)
        
        usernameOutlet.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 30, bottom: 0, right: 30))
        
        usernameValidationOutlet.anchor(top: usernameOutlet.bottomAnchor, leading: usernameOutlet.leadingAnchor, bottom: nil, trailing: usernameOutlet.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        passwordOutlet.anchor(top: usernameValidationOutlet.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        passwordValidationOutlet.anchor(top: passwordOutlet.bottomAnchor, leading: passwordOutlet.leadingAnchor, bottom: nil, trailing: passwordOutlet.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        repeatedPasswordOutlet.anchor(top: passwordValidationOutlet.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        repeatedPasswordValidationOutlet.anchor(top: repeatedPasswordOutlet.bottomAnchor, leading: repeatedPasswordOutlet.leadingAnchor, bottom: nil, trailing: repeatedPasswordOutlet.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        signupOutlet.anchor(top: repeatedPasswordValidationOutlet.bottomAnchor, leading: repeatedPasswordValidationOutlet.leadingAnchor, bottom: nil, trailing: repeatedPasswordValidationOutlet.trailingAnchor, padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        signupOutlet.constrainHeight(constant: 40)
    }
    
}

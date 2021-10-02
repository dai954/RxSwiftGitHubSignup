//
//  ViewController.swift
//  RxSwiftGitHubSignup
//
//  Created by 石川大輔 on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
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
    
    
    let desposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
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


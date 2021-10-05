//
//  BindingExtensions.swift
//  RxSwiftGitHubSignup
//
//  Created by 石川大輔 on 2021/10/04.
//

import UIKit
import RxSwift

extension ValidationResult {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case .validating:
            return "validating..."
        case let .failed(message):
            return message
    }
    }
}

struct ValidationColor {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColor.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColor.errorColor
        }
    }
}

extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.text = result.description
            label.textColor = result.textColor
        }
    }
}

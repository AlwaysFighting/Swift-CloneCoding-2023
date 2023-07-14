//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 목정아 on 2023/07/14.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}

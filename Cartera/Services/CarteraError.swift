//
//  CarteraError.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/25/24.
//

import Foundation

enum CarteraError: Error {
    case networkError
    case urlError
    case parseError
    case dataError
    case unsafeError
    case genericError
}

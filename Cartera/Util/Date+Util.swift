//
//  Date+Util.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/28/24.
//

import Foundation

extension String {
    
    func shortDateFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "MMM yyyy"
            
            return outputDateFormatter.string(from: date)
        }
        
        return nil
    }
    
}

//
//  DateFormatter+Extensions.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import Foundation

extension DateFormatter {
    static let eventDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter
    }()
}

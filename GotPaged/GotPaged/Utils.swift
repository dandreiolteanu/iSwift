//
//  Utils.swift
//  GotPaged
//
//  Created by Olteanu Andrei on 07/07/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import Foundation

enum WeekDay {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday

    var string: String {
        switch self {
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        }
    }
}

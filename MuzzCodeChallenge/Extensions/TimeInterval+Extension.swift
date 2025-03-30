//
//  TimeInterval+Extension.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 28/03/2025.
//

import Foundation

extension TimeInterval {
    public static var tenSeconds: TimeInterval { return 10 }
    public static var oneMinute: TimeInterval { return 60 }
    public static var fiveMinutes: TimeInterval { return oneMinute * 5 }
    public static var fifteenMinutes: TimeInterval { return oneMinute * 15 }
    public static var thirtyMinutes: TimeInterval { return fifteenMinutes * 2 }
    public static var oneHour: TimeInterval { return thirtyMinutes * 2 }
    public static var twoHour: TimeInterval { return oneHour * 2 }
    public static var threeHours: TimeInterval { return oneHour * 3 }
    public static var fourHours: TimeInterval { return oneHour * 4 }
    public static var sixHours: TimeInterval { return oneHour * 6 }
    public static var eightHours: TimeInterval { return oneHour * 8 }
    public static var twelveHours: TimeInterval { return sixHours * 2 }
    public static var twentyFourHours: TimeInterval { return twelveHours * 2 }
}

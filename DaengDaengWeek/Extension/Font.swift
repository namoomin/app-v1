//
//  Font.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import Foundation
import SwiftUI

extension Font {
    enum Daengs {
        case bold
        case regular
        case light
        case custom(String)
        
        var value: String {
            switch self {
            case .bold:
                return "EF_Rainyday-B"
            case .regular:
                return "EF_Rainyday-R"
            case .light:
                return "EF_Rainyday-L"
            case .custom(let name):
                return name
            }
        }
    }

    static func dw(_ type: Daengs, size: CGFloat = 14) -> Font {
        return .custom(type.value, size: size)
    }
}

//
//  Color+Extension.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/26/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)

        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let r = Double((color & 0xFF0000) >> 16) / 255.0
        let g = Double((color & 0x00FF00) >> 8) / 255.0
        let b = Double(color & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

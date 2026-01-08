//
//  DerKleineFreitagUI.swift
//  DerKleineFreitagUI
//
//  Created by Oliver Bayer on 08.01.26.
//

import Foundation
import DerKleineFreitagKit
import SwiftUI

public struct DerKleineFreitagView: View {
    let date: Date
    let localeIdentifier: String

    public init(date: Date, localeIdentifier: String = "de") {
        self.date = date
        self.localeIdentifier = localeIdentifier
    }

    public var body: some View {
        let formatter = CustomWeekDayFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        // We want the full custom weekday string
        formatter.dateFormat = "EEEE"
        let dayName = formatter.string(from: date)

        // Standard date for context
        let standardFormatter = DateFormatter()
        standardFormatter.locale = Locale(identifier: localeIdentifier)
        standardFormatter.dateStyle = .medium
        standardFormatter.timeStyle = .none
        let dateString = standardFormatter.string(from: date)

        return ZStack {
            ContainerRelativeShape()
                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))

            VStack(spacing: 4) {
                Text(dayName)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.horizontal)

                Text(dateString)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
    }
}

//
//  WidgetExample.swift
//  This file contains the code you need to add to your Widget Target in Xcode.
//  It assumes you have added 'DerKleineFreitagCore' as a dependency to your Widget Extension.
//

import WidgetKit
import SwiftUI
import DerKleineFreitagKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline for the current day
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate)
        entries.append(entry)

        // Refresh at midnight
        let calendar = Calendar.current
        if let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate),
           let nextMidnight = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: nextDay) {
            let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
            completion(timeline)
        } else {
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DerKleineFreitagWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    private let formatter: CustomWeekDayFormatter = {
        let formatter = CustomWeekDayFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEEE" // Full custom name

        return formatter
    }()

    @ViewBuilder
    var body: some View {
        switch family {
        case .accessoryInline:
            let dayName = formatter.string(from: entry.date)
            Text(dayName)

        case .accessoryCircular:
            ZStack {
                Text(formatter.string(from: entry.date).prefix(1)) // Just first letter
                    .font(.headline)
            }

        case .accessoryRectangular:
            HStack {
                VStack(alignment: .leading) {

                    Text(formatter.string(from: entry.date))
                        .font(.headline)
                        .widgetAccentable()

                    Text(entry.date, style: .date)
                        .font(.caption)
                }
                Spacer()
            }
            
        default:
            // Standard Home Screen Widgets
            DerKleineFreitagView(date: entry.date, localeIdentifier: Locale.current.identifier)
        }
    }
}

struct DerKleineFreitagWidget: Widget {
    let kind: String = "DerKleineFreitagWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DerKleineFreitagWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Der kleine Freitag")
        .description("Zeigt den aktuellen Wochentag mit speziellen Namen.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

// Preview Provider
struct DerKleineFreitagWidget_Previews: PreviewProvider {
    static var previews: some View {
        DerKleineFreitagWidgetEntryView(entry: SimpleEntry(date: Date()))
            .containerBackground(.background, for: .widget)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

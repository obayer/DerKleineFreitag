import Foundation

/// A custom `DateFormatter` subclass that overrides specific weekday names with fun, culturally localized alternatives.
///
/// `CustomWeekDayFormatter` automatically replaces standard weekday names (e.g., "Monday", "Wednesday") with custom terms
/// defined in the module's string catalog. For example, in German, "Donnerstag" becomes "der kleine Freitag".
///
/// Usage:
/// ```swift
/// let formatter = CustomWeekDayFormatter()
/// formatter.dateFormat = "EEEE"
/// print(formatter.string(from: Date())) // Output might be "der kleine Freitag"
/// ```
public final class CustomWeekDayFormatter: DateFormatter, Sendable, @unchecked Sendable {

    // Configuration: Map weekday index to localization key
    // 0: Sun, 1: Mon, 2: Tue, 3: Wed, 4: Thu, 5: Fri, 6: Sat
    private let weekdayKeys: [Int: String] = [
        1: "weekday.monday",    // Montag
        3: "weekday.wednesday", // Mittwoch
        4: "weekday.thursday",  // Donnerstag
        5: "weekday.friday"     // Freitag
    ]
    
    /// Initializes a new instance of `CustomWeekDayFormatter`.
    ///
    /// Upon initialization, the formatter sets its locale to `Locale.current` and applies the custom weekday symbols.
    public override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.locale = Locale.current
        applyCustomSymbols()
    }
    
    /// The locale of the receiver.
    ///
    /// Setting this property triggers a re-application of the custom weekday symbols to ensure they match the format expected,
    /// although the text translation itself currently relies on the main bundle's active localization.
    public override var locale: Locale! {
        didSet {
            applyCustomSymbols()
        }
    }
    
    private func applyCustomSymbols() {
        // Get standard symbols for the current locale
        // We create a temporary formatter to get the default symbols for this locale
        let tempFormatter = DateFormatter()
        tempFormatter.locale = self.locale
        var symbols = tempFormatter.weekdaySymbols ?? []
        
        // Safety check
        guard symbols.count == 7 else { return }
        
        // Apply overrides using localized strings from the module bundle
        for (index, key) in weekdayKeys {
            if index >= 0 && index < 7 {
                // Use String(localized: ..., bundle: .module) which respects the app's current language context.
                let localizedName = String(localized: String.LocalizationValue(key), bundle: .module)
                symbols[index] = localizedName
            }
        }
        
        self.weekdaySymbols = symbols
    }
}

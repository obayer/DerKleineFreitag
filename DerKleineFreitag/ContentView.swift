import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Vorschau der Widget-Ansicht:")
                .font(.headline)
                .padding()
            
            // This displays the shared view from the Core framework
            // giving you an immediate preview in the App itself.
            DerKleineFreitagView(date: Date(), localeIdentifier: Locale.current.identifier)
                .frame(width: 160, height: 160) // Simulating small widget size
                .cornerRadius(20)
                .shadow(radius: 5)
            
            Spacer()
                .frame(height: 50)
            
            Text("Füge das Widget deinem Homescreen hinzu, um es in Aktion zu sehen.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}

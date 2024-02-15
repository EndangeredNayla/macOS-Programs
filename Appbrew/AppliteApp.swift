//
//  AppliteApp.swift
//  Applite
//
//  Created by Milán Várady on 2022. 09. 24..
//

import Foundation
import SwiftUI

@main
struct AppliteApp: App {
    @StateObject var caskData = CaskData()
    
    @AppStorage(Preferences.colorSchemePreference.rawValue) var colorSchemePreference: ColorSchemePreference = .system
    @AppStorage(Preferences.setupComplete.rawValue) var setupComplete: Bool = false
    
    var selectedColorScheme: ColorScheme? {
        switch colorSchemePreference {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if setupComplete {
                ContentView()
                    .environmentObject(caskData)
                    .frame(minWidth: 970, minHeight: 520)
                    .preferredColorScheme(selectedColorScheme)
            } else {
                SetupView()
                    .frame(width: 600, height: 400)
                    .preferredColorScheme(selectedColorScheme)
            }
        }
        .windowResizability(.contentSize)
        
        Window("Uninstall \(Bundle.main.appName)", id: "uninstall-self") {
            UninstallSelfView()
                .padding()
                .preferredColorScheme(selectedColorScheme)
        }
        .windowResizability(.contentSize)
        
        WindowGroup("Shell Output", for: String.self) { $errorString in
            ErrorWindowView(errorString: errorString ?? "N/a")
        }
    }
}

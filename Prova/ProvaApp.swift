//
//  ProvaApp.swift
//  Prova
//
//  Created by Mattia Marini on 21/07/24.
//

import SwiftUI

@main
struct ProvaApp: App {
	@StateObject var globalState = GlobalState()
    var body: some Scene {
        WindowGroup {
					ContentView()
						.frame(minWidth: 500, minHeight: 300)
						.environmentObject(globalState)
        }
    }
}

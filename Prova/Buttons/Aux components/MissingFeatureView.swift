//
//  MissingFeatureView.swift
//  Prova
//
//  Created by Mattia Marini on 23/07/24.
//

import SwiftUI

struct MissingFeatureView:View {
	var body: some View {
		VStack{
			Spacer()
			HStack{
				Spacer()
				ContentUnavailableView {
					Label("Feature not implemented", systemImage: "tray.fill")
				} description: {
					Text("This will probably be implemented in the near future")
				}
				Spacer()
			}
			Spacer()
			
			//Text("virtualDoublePress")
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

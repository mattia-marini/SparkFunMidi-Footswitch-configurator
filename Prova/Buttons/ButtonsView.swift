//
//  ButtonsView.swift
//  Prova
//
//  Created by Mattia Marini on 22/07/24.
//

import SwiftUI
import AudioToolbox



struct ButtonsView: View{

	
	var body: some View{
		VStack(spacing:0){
			Divider()
			Text("In this section you should declare all the buttons that your phisical controller has. You can also add virtual buttons, i.e.  combination of button that if pressed toghether count as a norma button press").padding()
				.multilineTextAlignment(.center)
				.clipped()
			Divider()
			HSplitView{
				ButtonListView()
				CreateButtonAssignmentView()
			}
		}
	}
}


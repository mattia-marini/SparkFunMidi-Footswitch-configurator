//
//  ButtonList.swift
//  Prova
//
//  Created by Mattia Marini on 23/07/24.
//

import SwiftUI

struct Map : Identifiable{
	
	var id: UUID = UUID()
	
	var lhs: String
	var description : String
}

	let maps = [
		Map(lhs: "[N]", description: "maps a single physical switch"),
		Map(lhs: "[VM]", description: "maps the press of 2 of more physical switches simultaneously"),
		Map(lhs: "[VL]", description: "maps the long press of single switch"),
		Map(lhs: "[VD]", description: "maps the quick double press of a single switch")
	]

struct ButtonListView: View {
	@EnvironmentObject var globalState : GlobalState
	
	@State private var selection : Set<UUID> = []
	@State private var isExpanded : [String: Bool] = [:]
	
	@State private var showingAlert: Bool = false
	@State private var isExpandedPhysical: Bool = true
	@State private var isExpandedVirtual: Bool = true
	
	@State private var showInfoSheet: Bool = false
	
	
	
	var body: some View {
		VStack (spacing:0){
			
			List(selection: $selection){
				ForEach(globalState.buttonAssignmentList.keys.sorted(), id: \.self) { key in
					DisclosureGroup(
						isExpanded: Binding(
							get: { self.isExpanded[key] ?? false },
							set: { self.isExpanded[key] = $0 }
						)
					) {
						if !globalState.buttonAssignmentList[key]!.isEmpty{
							ForEach(globalState.buttonAssignmentList[key]!) { item in
								Text(item.toString())
							}
						}
					} label: {
						Text(key)
					}
					.onAppear {
						if self.isExpanded[key] == nil {
							self.isExpanded[key] = true
						}
					}
				}
			}
			.backgroundStyle(.background)
			.onDeleteCommand(perform: {
				if !selection.isEmpty{
					showingAlert = true
				}})
			
			Divider()
			
			HStack(spacing:0){
				Button {
					if !selection.isEmpty{
						showingAlert = true
					}
				} 
			label: {
					Image(systemName: "minus")
						.frame(width: 25, height: 25)
						.background(Color.init(red: 1, green: 1, blue: 1, opacity: 0.001))
					//.frame(width: 30, height: 30)
				}
				.buttonStyle(.plain)
				
				Spacer()
				Button{
					showInfoSheet = true
				}
			label:{
				Image(systemName: "questionmark")
					.frame(width: 25, height: 25)
					.background(Color.init(red: 1, green: 1, blue: 1, opacity: 0.001))
			}
			.buttonStyle(.plain)
			.sheet(isPresented: $showInfoSheet){
				
				
				VStack(alignment: .leading) {
					Text("Assignments: ").font(.headline)
					Divider()
					Table(maps){
						TableColumn("LHS", value: \.lhs).width(min:50, ideal:50, max:50)
						TableColumn("Description", value: \.description).width(min:50, ideal:450, max: 450)
					}
					.frame(width: 500, height: 150)
					
				}.padding()
			}
			.interactiveDismissDisabled(false)
				
				
			}
		}
		.alert(Text("Delete button?"),
					 isPresented: $showingAlert,
					 actions: {
			Button("Confirm") {
				deleteSelectedItems()
			}
			Button("Cancel", role: .cancel) { }
		}, message: {
			Text("That will remove the button declaration and any mapping associated with it")
		})
	}
	
	
	private func deleteSelectedItems() {
		
		for (key, _) in globalState.buttonAssignmentList{
			globalState.buttonAssignmentList[key]! = globalState.buttonAssignmentList[key]!.filter { item in
				!selection.contains(item.id)
			}
		}
		
		selection.removeAll()
	}
	
}

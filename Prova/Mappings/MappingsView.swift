//
//  MappingsView.swift
//  Prova
//
//  Created by Mattia Marini on 26/07/24.
//

import SwiftUI



struct MappingsView: View {
	
	@EnvironmentObject var globalState : GlobalState
	@State private var selection : Set<MapPair.ID> = []
	@State var myList = [
	MapPair(buttonAssignment: .init("prova1"), action: .init()),
	MapPair(buttonAssignment: .init("prova2"), action: .init())
	]
	
	var body: some View {
		
		VStack{
			Table(globalState.mappings, selection: $selection){
				TableColumn("Colonna 1", value: \.buttonAssignment.btnName)
				TableColumn("Colonna 2", value: \.action.desc)
			}
		}
			
			/*
			Table(arr, selection: $selection) {
				TableColumn("Colonna 1", value: \.buttonAssignment.btnName)
				TableColumn("Colonna 2", value: \.action.desc)
			}
			 */
		.onAppear{
			print(globalState.mappings.map{ $0 })
		}
		
	}

	/*
	func makeArray(_ array : [ButtonAssignment : Action]) -> [MapPair]{
		let keys = Array(array.keys)
		var rv : [MapPair] = []
		
		for key in keys {
			rv.append(MapPair(buttonAssignment:key, action:globalState.mappings[key]!))
		}
		
		return rv
	}
	 */
	
}

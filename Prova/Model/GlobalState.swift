//
//  GlobalState.swift
//  Prova
//
//  Created by Mattia Marini on 24/07/24.
//

import Foundation

class GlobalState : ObservableObject{
	@Published var buttonAssignmentList: [String : [ButtonAssignment]] = [
		"Physical" : [
			PhysicalButtonAssignment()
		],
		
		"Virtual" : [
			VirtualMultipleButtonAssignment()
		]
	]
	
	
	@Published var mappings : [MapPair] = [
		MapPair(buttonAssignment: PhysicalButtonAssignment() , action: MidiNoteAction(channel: 1, value: 13)),
		MapPair(buttonAssignment: VirtualMultipleButtonAssignment() , action: MidiAction(channel: 2, value: 15))
	]
	
}

struct MapPair : Identifiable{
	var buttonAssignment : ButtonAssignment
	var action : Action
	var id = UUID()
}

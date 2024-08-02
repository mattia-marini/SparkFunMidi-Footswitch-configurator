//
//  ButtonAssignment.swift
//  Prova
//
//  Created by Mattia Marini on 24/07/24.
//

import Foundation


enum ButtonAssignmentType: String {
	case physical = "Physical"
	case virtualMultiple = "Virtual (multiple presses)"
	case virtualLongPress = "Virtual (long press)"
	case virtualDoublePress = "Virtual (quick double press)"
}

class ButtonAssignment: ObservableObject, Identifiable, Hashable{
	
	var id : UUID = UUID()
	@Published var buttonType : ButtonAssignmentType = .physical
	@Published var btnName = "Btn 0"
	
	init(_ btnName : String){
		self.btnName = btnName
	}
	func toString() -> String{
			 return "ButtonAssignment: \(id), Type: \(buttonType)"
	}
	
	static func == (lhs:  ButtonAssignment, rhs: ButtonAssignment) -> Bool {
			return lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
			hasher.combine(btnName)
	}
}



class PhysicalButtonAssignment : ButtonAssignment{
	init(){ super.init("Default physical"); buttonType = .physical }
	
	static let description = "Maps single press of a single physical button"
	
	@Published var pinId :Int = 0
	@Published var debounceTime : Int = 15
	
	
	init(pinId: Int, btnName: String, debounceTime : Int = 15) {
		super.init(btnName)
		self.pinId = pinId
		self.debounceTime = debounceTime
	}
	
	override func toString() -> String{
		return "Pin \(pinId) -> \(btnName)"
	}
}


class VirtualMultipleButtonAssignment : ButtonAssignment{
	init(){ super.init("Default virtual"); buttonType = .virtualMultiple }
	
	static let description = "Pressing the given buttons at the same time will map to single press"
	
	@Published var pinIds :[Int] = []
	@Published var debounceTime : Int = 15
	
	init(pinIds: [Int], btnName: String, debounceTime : Int = 15) {
		super.init(btnName)
		self.pinIds = pinIds
		self.debounceTime = debounceTime
	}
	
	
	override func toString() -> String{
		return "[VM] Pin \(pinIds) -> \(btnName)"
	}
}

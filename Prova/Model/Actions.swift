//
//  Action.swift
//  Prova
//
//  Created by Mattia Marini on 26/07/24.
//

import Foundation



enum ActionType : String{
	case midiActionType = "Send midi note/CC/PC"
}

enum MidiActionType : String{
	case sendMidiNote = "Send a midi on and midi off msg"
	case sendMidiPC = "Send midi program change msg"
	case sendMidiCC = "Send midi control change msg"
}

enum ActionError: Error {
	case channelOutOfRange
	case valueOutOfRange
}


class Action{
	var desc : String{
		return "That's a default action"
	}
}

class MidiAction : Action{
	var channel : Int = 1
	var value : Int = 42
	let actionType = ActionType.midiActionType
	
	init(channel: Int, value: Int) {
		if channel < 1 || channel > 16 {
			fatalError("Channel out of range (1-16).")
		}
		if value < 0 || value > 127 {
			fatalError("Value out of range (0-127).")
		}
		self.channel = channel
		self.value = value
	}
	
	override var desc : String{ "MidiAction [c \(channel), value \(value)]" }
}

class MidiNoteAction : MidiAction{
	private var onVelocity : Int = 127
	private var offVelocity : Int = 0
	static let desc = MidiActionType.sendMidiNote.rawValue
	
	override var desc : String{ "MidiNoteAction [channel \(channel), note \(value), onVel \(onVelocity), offVel \(offVelocity)]" }
}

class MidiPCAction : MidiAction{
	static let desc = MidiActionType.sendMidiCC.rawValue
	override var desc : String{ "MidiPCAction [c \(channel), value \(value)]" }
}

class MidiCCAction : MidiAction{
	static let desc = MidiActionType.sendMidiPC.rawValue
	override var desc : String{ "MidiCCAction [c \(channel), value \(value)]" }
}

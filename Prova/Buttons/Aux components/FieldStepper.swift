//
//  FieldStepper.swift
//  Prova
//
//  Created by Mattia Marini on 23/07/24.
//

import SwiftUI
import AudioToolbox

struct FieldStepper: View {
	
	@State var label : String
	@Binding var value : Int
	
	@State private var textValue: String = ""
	@FocusState private var isFocused: Bool
	
	init(label: String, value: Binding<Int>) {
		_label = State(initialValue: label)
		textValue = String(value.wrappedValue)
		_value = value
	}
	
	private func checkValueNoSound() -> Bool{
		if let newValue = Int(textValue) {
			if newValue >= 0 && newValue <= 100 {
				return true
			}
		}
		return false
	}
	
	private func checkValue() -> Bool{
		if let newValue = Int(textValue) {
			if newValue >= 0 && newValue <= 100 {
				return true
			}
		}
		AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_UserPreferredAlert))
		return false
	}
	
	private func checkAndSetValue() -> Bool{
		if let newValue = Int(textValue) {
			if newValue >= 0 && newValue <= 100 {
				value = newValue
				textValue = String(newValue)
				return true
			}
		}
		AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_UserPreferredAlert))
		return false
	}
	
	
	var body: some View {
		
		HStack {
			TextField(label, text: $textValue)
				.multilineTextAlignment(.trailing)
				.focused($isFocused)
				.onChange(of: value) { _, newValue in
					if !checkValue(){return}
					textValue = String(newValue)
				}
				.onChange(of: isFocused) { _, focused in
					if !focused && !checkAndSetValue(){
						isFocused = true
					}
				}
				.onChange(of: textValue) { _, newText in
					if checkValueNoSound() {
						value = Int(newText)!
					}
				}
				.onSubmit {
					let _ = checkAndSetValue()
				}
			Stepper("", value: $value, in: 0...127)
				.labelsHidden()
		}
		
	}
}

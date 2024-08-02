//
//  CellListView.swift
//  Prova
//
//  Created by Mattia Marini on 25/07/24.
//

import SwiftUI

struct CellListView: View {
	
	@Binding var cells : [Int]
	@Binding var selection : Set<Int>
	
	@FocusState private var focused: Bool
	
	@State var lastClick = -1
	
	var body: some View {
		HStack{
			ForEach(Array(cells.enumerated()), id: \.element){ index, item in
				Text("\(item)")
					.padding(10)
					.background()
					.overlay(
						RoundedRectangle(cornerRadius: 4)
							.stroke(selection.contains(item) ? Color.blue : Color.black, lineWidth: 1)
					)
					.onTapGesture {
						if NSEvent.modifierFlags.contains(.command){
							if selection.contains(item){
								selection.remove(item)
							}else{
								selection.insert(item)
							}
							lastClick = index
						}
						else if NSEvent.modifierFlags.contains(.shift){
							
							selection.removeAll()
							
							if lastClick < 0 || lastClick >= cells.count {
								selection.insert(item)
								lastClick = index
							}
							
							for x in min(lastClick, index)...max(lastClick, index) {
								selection.insert(cells[x])
							}
							
						}
						else{
							selection.removeAll()
							selection.insert(item)
							lastClick = index
						}
					}
			}
		}
		.focusable()
		.focused($focused)
		.focusEffectDisabled()
		.onKeyPress(KeyEquivalent("\u{7F}")){
			removeSelectedItems()
			return .handled
		}
		.onTapGesture {
			print("prova")
			selection.removeAll()
		}
		
	}
	
	func removeSelectedItems(){
		cells = cells.filter{item in
			!selection.contains(item)
		}
		selection.removeAll()
	}
}


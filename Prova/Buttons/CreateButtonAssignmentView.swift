//
//  ButtonViewDetails.swift
//  Prova
//
//  Created by Mattia Marini on 23/07/24.
//

import SwiftUI





struct CreateButtonAssignmentView:View {
	
	@State private var count: Int = 0
	@State private var selectedButtonType: ButtonAssignmentType = .physical
	
	
	
	var body: some View {
		
		ScrollView{
			Form{
				VStack(alignment: .leading){
					
					
					Text("Button type")
						.font(.headline).foregroundStyle(Color.gray)
					//.font(.system(size: 14))
					//.bold()
					
					Divider()
					
					Menu{
						Button("Phisical button"){
							selectedButtonType = .physical
							print("menu")
						}
						Divider()
						Button("Virtual button (multiple presses)"){
							selectedButtonType = .virtualMultiple
							print("menu")
						}
						Button("Virtual button (long press)"){
							selectedButtonType = .virtualLongPress
							print("menu")
						}
						Button("Virtual button (quick double press)"){
							selectedButtonType = .virtualDoublePress
							print("menu")
						}
					}
				label: {
					Text(selectedButtonType.rawValue)
				}
					
					switch selectedButtonType {
					case .physical:
						PhysicalDetailsView()
						//Text("physical")
					case .virtualMultiple:
						VirtualMultipleDetailsView()
						//Text("virtualMultiple")
					case .virtualLongPress:
						MissingFeatureView()
					case .virtualDoublePress:
						MissingFeatureView()
					}
				}
			}
			.padding()
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}






// Physical ########################################

struct PhysicalDetailsView : View {
	@EnvironmentObject var globalState: GlobalState
	
	@State var pinId : Int = 0
	@State var btnName : String = ""
	@State var debounceTime : Int = 15
	
	var body: some View {
		VStack (alignment: .leading){
			Text("Basic settings").font(.headline).foregroundStyle(Color.gray)
			FieldStepper(label:"Board pin", value: $pinId).padding(.leading)
			TextField("Button name", text: $btnName).padding(.leading)
			
			Divider()
			
			Text("Advanced settings").font(.headline).foregroundStyle(Color.gray)
			FieldStepper(label: "Debounce time", value: $debounceTime).padding(.leading)
			
			Divider()
			
			HStack{
				Spacer()
				Button("Add"){
					globalState.buttonAssignmentList["Physical"]!.append(PhysicalButtonAssignment(pinId: pinId, btnName: btnName, debounceTime: debounceTime))
				}
			}
		}
	}
}

struct VirtualMultipleDetailsView : View {
	@EnvironmentObject var globalState: GlobalState
	
	@State var pinId : Int = 0
	@State var selectedPins : Set<Int> = []
	
	@State var pinIds : [Int] = [1,2,3]
	@State var btnName : String = ""
	@State var debounceTime : Int = 15
	
	@State var alert : Bool = false
	
	var cellListView: CellListView {
		CellListView(cells: $pinIds, selection: $selectedPins)
	}
	
	
	
	
	var body: some View {
		VStack (alignment: .leading){
			Text("Basic settings").font(.headline).foregroundStyle(Color.gray)
			
			if pinIds.isEmpty {
				VStack {
					Text("<Here you will see added pins>").font(.subheadline).foregroundStyle(.gray).padding(10)
				}
				.frame(maxWidth: .infinity)
			}
			else{
				cellListView
			}
			
			HStack{
				FieldStepper(label:"Board pin", value: $pinId).padding(.leading)
					.onSubmit {
						if pinIds.contains(pinId){
							alert = true
						}
						else {
							pinIds.append(pinId)
						}
					}
				Button{
					if pinIds.contains(pinId){
						alert = true
					}
					else {
						pinIds.append(pinId)
					}
				}label:{
					Image(systemName: "plus")
						.frame(width: 25, height: 25)
						.background(Color.init(red: 1, green: 1, blue: 1, opacity: 0.001))
				}.buttonStyle(.accessoryBarAction)
				
				Button{
					cellListView.removeSelectedItems()
				}label:{
					Image(systemName: "minus")
						.frame(width: 25, height: 25)
						.background(Color.init(red: 1, green: 1, blue: 1, opacity: 0.001))
				}.buttonStyle(.accessoryBarAction)
			}
			
			TextField("Button name", text: $btnName).padding(.leading)
			
			Divider()
			
			Text("Advanced settings").font(.headline).foregroundStyle(Color.gray)
			FieldStepper(label: "Debounce time", value: $debounceTime).padding(.leading)
			
			Divider()
			
			HStack{
				Spacer()
				Button("Add"){
					globalState.buttonAssignmentList["Virtual"]!.append(VirtualMultipleButtonAssignment(pinIds: pinIds, btnName: btnName, debounceTime: debounceTime))
				}
			}
		}
		.alert(isPresented: $alert){
			Alert (
				title: Text("Duplicate"),
				message: Text("You are trying to insert a duplicate pin in the pin list"),
				dismissButton: .default(Text("Ok"))
			)
		}
		
	}
}


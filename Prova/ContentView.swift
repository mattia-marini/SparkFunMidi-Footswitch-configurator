//
//  ContentView.swift
//  Prova
//
//  Created by Mattia Marini on 21/07/24.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
			TabView{
				ButtonsView()
					.tabItem { Text("Buttons") }
				MappingsView()
					.tabItem { Text("Mappings") }
				SearchForDeviceView()
					.tabItem { Text("SearchDevice") }
			}
				
        /*
        TabView{
                
            }
                .tabItem { Text("Buttons") }
            Text("2")
                .tabItem { Text("Mappings") }
        }
         */
    }
}


/*
struct ContentView: View {
    @State private var oneIsOn: Bool = false
    @State private var twoIsOn: Bool = true
    @State private var isExpanded: Bool = true
    
    @State private var selectedFolder: UUID = UUID()
    
    @State private var text: String = ""
    
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        
        NavigationSplitView{
            List(selection: viewModel.$selectedItem) {
                Section("Buttons") {
                    Text("Phisical buttons")
                    Text("Virtual buttons")
                }
            }.listStyle(.sidebar)
            .navigationTitle("Navigation Split View")
        }
    content:{
        Text("prova")
    }
    detail:{
        Text("prova")
    }
        
        /*
        VSplitView{
            VStack(alignment: .leading){
                List{
                    DisclosureGroup("Prova"){
                        GroupBox{
                            VStack(spacing:10){
                                List(viewModel.items, selection: $viewModel.selectedItems) { item in
                                    HStack{
                                        Text(item.name)
                                        Spacer()
                                        Button("-"){
                                            print("Rimuovo " + item.name)
                                        }.buttonStyle(.accessoryBarAction)
                                    }
                                }
                                .backgroundStyle(.cyan)
                                .navigationTitle("Multiple Selection")
                                HStack{
                                    TextField("Inserisci un nuovo bottone", text: $text)
                                        .textFieldStyle(.squareBorder)
                                    Spacer()
                                    Button("prova"){}
                                }
                            }
                        }
                        .background()
                        .frame(height: 200)
                    }
                    DisclosureGroup("Prova"){
                        Text("rova")
                    }
                }
                
                List{
                    Text("prova")
                    Text("prova")
                    Text("prova")
                    Text("prova")
                    Text("prova")
                }
            }
            
            /*
             List(selection: $multiSelection){
             Section{
             /*
              Text("prova di una entry")
              Toggle("Toggle 1", isOn: $oneIsOn)
              Toggle("Toggle 2", isOn: $twoIsOn)
              HStack{
              Button("+"){
              print("Config")
              }.buttonStyle(.accessoryBarAction)
              Spacer()
              Button("-"){
              print("Config")
              }.buttonStyle(.accessoryBarAction)
              */
             Label("Sun", systemImage: "sun.max")
             Label("Cloud", systemImage: "cloud")
             Label("Rain", systemImage: "cloud.rain")
             }
             }
             */
        }
         
         */
        
    }
    
    
}


struct Item: Identifiable {
    let id = UUID()
    let name: String
}

class ViewModel: ObservableObject {
    @Published var items: [Item] = [
        Item(name: "Item 1"),
        Item(name: "Item 2"),
        Item(name: "Item 3"),
        Item(name: "Item 4")
    ]
    
    @Published var selectedItems: Set<UUID> = []
    @Published var selectedItem: Set<UUID> = []
}

 */

/*
 #Preview {
 ContentView()
 }
 */

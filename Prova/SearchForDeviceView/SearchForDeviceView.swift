//
//  SearchForDeviceView.swift
//  Prova
//
//  Created by Mattia Marini on 26/07/24.
//

import SwiftUI

struct SearchForDeviceView: View {
	
	@State var count = 0
	@State var deviceName = ""
	@State var searcher : AsynchDeviceSearcher? = nil
	
	@State private var showInfoSheet: Bool = false
	
	var body: some View {
		let _ = print("body")
		VStack{
			Button("Show sheet"){
				showInfoSheet = true
			}
		}
		.sheet(isPresented: $showInfoSheet){
			VStack{
				if deviceName == "" {
					
					HStack{
						ProgressView().progressViewStyle(.circular)
						Text("Searchin for a controller").font(.headline)
					}
				}
				else{
					HStack{
						Image(systemName: "cellularbars").resizable().frame(width: 30, height: 30)
						Text(deviceName).font(.headline).bold()
					}
				}
			}
			.frame(width: 400, height: 200)
			.padding()
			.onAppear{
				print("onAppear")
				
				searcher = AsynchDeviceSearcher(name: "iPhone"){status, deviceInfos in
					print(status)
					if status == 1, let deviceInfos = deviceInfos {
						deviceName = deviceInfos[0].deviceName
					}else{
						deviceName = ""
					}
				}
				
				searcher!.start()
			}
			.onDisappear{
				print("onDisappear")
				searcher!.cancel()
			}
		}
	}
}



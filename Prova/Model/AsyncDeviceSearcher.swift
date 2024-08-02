//
//  AsyncDeviceSearcher.swift
//  Prova
//
//  Created by Mattia Marini on 26/07/24.
//

import Cocoa
import IOKit
import IOKit.usb

struct DeviceInfos{
	
	let deviceName : String
	let deviceId : Int
	let deviceClass : Int
	let deviceLocationID : Int
	
	var stringRep: String {
		return "Device <\(deviceId)> - \(deviceName)\nDevice class: \(deviceClass)\nDevice location id: \(deviceLocationID)"
	}
}


class AsynchDeviceSearcher {
	
	private var task : Task<(), Never>? = nil
	var name : String = "iPhone"
	var notify : (_ status : Int, _ deviceInfo : [DeviceInfos]?) -> Void
	var timeOut : Double = .infinity
	
	private var finished = false;
	private var started = false;
	private var isCanceled = false;
	
	
	init(name: String, completion: @escaping (_ status : Int, _ deviceInfo : [DeviceInfos]?) -> Void, timeout : Double = .infinity) {
		print("init")
		self.name = name
		self.notify = completion
	}
	
	func searchDeviceByName(_ deviceName : String) -> [DeviceInfos]? {
		let matchingDict = IOServiceMatching(kIOUSBDeviceClassName)
		let masterPort = kIOMainPortDefault
		var iterator: io_iterator_t = 0
		
		let kernResult = IOServiceGetMatchingServices(masterPort, matchingDict, &iterator)
		
		var rv : [DeviceInfos] = []
		//print(iterator)
		
		
		if kernResult == KERN_SUCCESS {
			var device: io_object_t = 0
			device = IOIteratorNext(iterator)
			while (device != 0) {
				if let deviceName = getDeviceInfos(device: device) {
					//print("Device Found: \(deviceName)")
					rv.append(deviceName)
				}
				device = IOIteratorNext(iterator)
				IOObjectRelease(device)
			}
			
			IOObjectRelease(iterator)
			return rv.isEmpty ? nil : rv
		}
		else {
			print("Failed to get matching services.")
			return nil
		}
	}
	
	
	func getDeviceInfos(device: io_object_t) -> DeviceInfos? {
		
		var props: Unmanaged<CFMutableDictionary>?
		if 0 != IORegistryEntryCreateCFProperties(device, &props, kCFAllocatorDefault, .zero) { return nil }
		//print(props)
		
		guard let infos_dict = props?.takeRetainedValue() as? [String: Any] else {return nil}
		
		
		return DeviceInfos(deviceName: infos_dict[kUSBProductString] as! String, deviceId: infos_dict[kUSBProductID] as! Int, deviceClass: infos_dict[kUSBDeviceClass] as! Int, deviceLocationID: infos_dict[kUSBDevicePropertyLocationID] as! Int )
	}
	
	
	
	func start(){
		started = true;
		task = Task (priority: .background){
			
			var timeElapsed : Double = 0
			while (!isCanceled && timeElapsed < timeOut){
				let deviceInfo = searchDeviceByName(name)
				let status = deviceInfo == nil ? 0 : 1
				notify(status , deviceInfo)
				timeElapsed += 1
				sleep(1)
			}
			//notify(-1, nil)
			finished = true
			// Call the completion closure to indicate the task is complete
		}
	}
	
	func join(){
		while (finished == false && !isCanceled) {sleep(1)}
	}
	
	func cancel(){
		isCanceled = true
	}
	
}

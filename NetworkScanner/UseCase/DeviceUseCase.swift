//
//  DeviceUseCase.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 23.04.24.
//

import Foundation

protocol DeviceUseCase {
    func fetchDevices() -> [DeviceModel]
}

class DeviceUseCaseImplementation: DeviceUseCase {
    
    private var devices = [DeviceModel]()
    
    private var device1: DeviceModel {
        .init(
            name: "Camera",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "gwpc-21141234.local",
            signal: true
        )
    }
    
    private var device2: DeviceModel {
        .init(
            name: "Phone",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "fibn-35841634.local",
            signal: true

        )
    }
    
    private var device3: DeviceModel {
        .init(
            name: "Router Trumplun",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "uubn-96341655.local",
            signal: false

        )
    }
    
    private var device4: DeviceModel {
        .init(
            name: "Router Trumplun",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "uubn-96341655.local",
            signal: true
        )
    }
    
    private var device5: DeviceModel {
        .init(
            name: "Camera",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "uiyr-95641655.local",
            signal: true
        )
    }
    
    private var device6: DeviceModel {
        .init(
            name: "Router Trumplun",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "qazf-58331655.local",
            signal: false
        )
    }
    
    private var device7: DeviceModel {
        .init(
            name: "Lamp",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "pqqq-56321655.local",
            signal: true
        )
    }
    
    private var device8: DeviceModel {
        .init(
            name: "Hoover",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "ecer-77321655.local",
            signal: true
        )
    }
    
    private var device9: DeviceModel {
        .init(
            name: "Lamp",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "hghf-77321999.local",
            signal: true
        )
    }
    
    private var device10: DeviceModel {
        .init(
            name: "Lamp",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "hgff-88321999.local",
            signal: true
        )
    }
    
    private var device11: DeviceModel {
        .init(
            name: "Lamp",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "ggff-55521999.local",
            signal: true
        )
    }
    
    private var device12: DeviceModel {
        .init(
            name: "Fridge",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "ttff-55521999.local",
            signal: true
        )
    }
    
    private var device13: DeviceModel {
        .init(
            name: "Microwave",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "tydf-55521999.local",
            signal: false

        )
    }
    
    private var device14: DeviceModel {
        .init(
            name: "Dishwasher",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "yyyf-55521999.local",
            signal: true
        )
    }
    
    private var device15: DeviceModel {
        .init(
            name: "Phone",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "yyyf-55521999.local",
            signal: true
        )
    }
    
    private var device16: DeviceModel {
        .init(
            name: "Mac_222",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "yyyf-55521999.local",
            signal: true
        )
    }
    
    private var device17: DeviceModel {
        .init(
            name: "ZTE-32",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "yyyf-55521999.local",
            signal: true
        )
    }
    
    private var device18: DeviceModel {
        .init(
            name: "Router Trumplun",
            conection: ConnectionTypes.wifi.rawValue,
            ipAddress: "192.168.1.1",
            macAddress: "Not Available",
            hostName: "yryf-55221999.local",
            signal: true
        )
    }
    
    func fetchDevices() -> [DeviceModel] {
        devices = [
            device1,
            device2,
            device3,
            device4,
            device5,
            device6,
            device7,
            device8,
            device9,
            device10,
            device11,
            device12,
            device13,
            device14,
            device15,
            device16,
            device17,
            device18,
        ]
        
        return devices
    }
    
}

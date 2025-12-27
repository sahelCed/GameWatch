//
//  RoomsRepository.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 21/12/2025.
//

import Foundation

struct RoomsRepository {
    
    static let cafeteria = Room(
        name: "Cafétéria",
        backgroundImageName: "cafeteria_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.18, centerYRelativeToHeight: 0.62, widthRelativeToMap: 0.20, heightRelativeToMap: 0.20)
    )
        
    static let laboReseau = Room(
        name: "Labo Réseau",
        backgroundImageName: "labo_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.18, centerYRelativeToHeight: 0.8075, widthRelativeToMap: 0.20, heightRelativeToMap: 0.155)
    )
    
    static let bureauAP = Room(
        name: "Bureau des AP",
        backgroundImageName: "administration_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.745, centerYRelativeToHeight: 0.82, widthRelativeToMap: 0.165, heightRelativeToMap: 0.14)
    )
        
    static let a04 = Room(
        name: "A04",
        backgroundImageName: "amphi_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.705, centerYRelativeToHeight: 0.6025, widthRelativeToMap: 0.24, heightRelativeToMap: 0.165)
    )
        
    static let a21 = Room(
        name: "A21",
        backgroundImageName: "a21_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.22, centerYRelativeToHeight: 0.38, widthRelativeToMap: 0.29, heightRelativeToMap: 0.17)
    )
        
    static let a22 = Room(
        name: "A22",
        backgroundImageName: "a22_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.255, centerYRelativeToHeight: 0.153, widthRelativeToMap: 0.35, heightRelativeToMap: 0.08)
    )
        
    static let espaceDetente = Room(
        name: "Espace détente",
        backgroundImageName: "rest_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.68, centerYRelativeToHeight: 0.29, widthRelativeToMap: 0.21, heightRelativeToMap: 0.35)
    )
        
    static let bureauSananes = Room(
        name: "Bureau du tyran Sananes",
        backgroundImageName: "tyran_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.22, centerYRelativeToHeight: 0.245, widthRelativeToMap: 0.29, heightRelativeToMap: 0.08)
    )
    
    static let exit = Room(
        name: "",
        backgroundImageName: "exit_background",
        roomLocation: RoomLocation(centerXRelativeToWidth: 0.48, centerYRelativeToHeight: 0.875, widthRelativeToMap: 0.1, heightRelativeToMap: 0.01)
    )
    
    static let playableRooms: [Room] = [
       cafeteria,
       laboReseau,
       bureauAP,
       a04,
       a21,
       a22,
       espaceDetente,
    ]
    
    static let allRooms: [Room] = playableRooms + [bureauSananes, exit]
    
}

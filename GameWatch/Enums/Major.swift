//
//  Major.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

enum Major: String, CaseIterable, Codable {
    case AL, MOC, IABD, SI, SRC, MCSI, BC, _3DJV = "3DJV", IW
    
    var fullName: String {
        switch self {
        case .AL: return "Architecture Logicielle"
        case .MOC: return "Mobilité & Objets Connectés"
        case .IABD: return "IA & Big Data"
        case .SI: return "Sécurité Informatique"
        case .SRC: return "Systèmes, Réseaux & Cloud"
        case .MCSI: return "Management & Conseil SI"
        case .BC: return "Blockchain"
        case ._3DJV: return "3D & Jeux Vidéo"
        case .IW: return "Ingénierie du Web"
        }
    }
}

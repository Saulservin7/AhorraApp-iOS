//
//  Room.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//


struct Room: Identifiable,Codable{
    let id:String
    let joinCode:String
    var nombre: String
    var usuarios:[String]
    var juego:Game
    var totalSave:Double
}

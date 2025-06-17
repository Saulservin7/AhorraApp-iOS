//
//  Game.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

enum GameType:String,Codable{
    case ruleta
    case trivia
}

enum GameData:Codable{
    case ruleta(initialRange:Int,endRange:Int,outputNumbers : [Int])
    case trivia(numberQuestions:Int)
}

struct Game:Codable{
    let type: GameType
    let title: String
    let data: GameData
}



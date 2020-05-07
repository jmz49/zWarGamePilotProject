//
//  extentionStatics.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

// MARK: - Game extension for static functions
extension Game {
   
    // MARK: - Global portability properties in the game
    
    static var counter: Int = 0
    
    // Array of used names
    static var usedNames: [String] = []
        
    static var teams: [Team] = []

    static var toggleWeapon = Weapon(weaponName: "toggle", effect: 0)
    
    static var memLife: Int = 0
    
    static var winner: Int = 1
    static var looser: Int = 0
    
    // MARK: - : Main function of the game

    fileprivate func startGame() {
        // titles
        print("\n\(constants.LINE)")
        print("       \(constants.GAME_TITLE)")
        print("\(constants.LINE)")
    }
    
    // Function to check if name is already used
    static func checkIfNameIsAlreadyUsed(name: String) -> Bool {
        return self.usedNames.contains(name.lowercased())
    }
    
    static func choiceNames()-> String {
        var FlagInputOK: Bool
        var returnedData: String = ""
        repeat {
            FlagInputOK = true
            if let inputData = readLine() {
                if inputData.count >= 2 {
                    let nameIsAlreadyUsed = Game.checkIfNameIsAlreadyUsed(name: inputData)
                    if nameIsAlreadyUsed {
                        print("\n   \(constants.USED_NAME)")
                        FlagInputOK = false
                    } else {
                        returnedData = inputData // transfert pour raisons de portée de variable
                        Game.usedNames.append(inputData.lowercased())
                    } // end of:  if nameIsAlreadyUsed {
                }else{ // if inputData.isEmpty {
                    FlagInputOK = false //toggle inputOK
                    print("\n   \(constants.VALID_NAME)")
                } // end of : if inputData.count >= 2 {
            } //end of : if let inputData = readLine() {
        }while FlagInputOK == false
        return returnedData
    } //end of : private func setPlayersNames() {
        
} // end of : class Game



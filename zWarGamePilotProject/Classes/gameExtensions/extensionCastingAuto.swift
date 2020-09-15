//
//  extensionCastingAuto.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

// MARK: - Game extension for castingAuto functions
extension Game {
    
    // Si nous sommes ici, dans cette fonction, c'est que l'instance de la classe Game existe
    
    func mainCastingAuto() {

        let gameName = constants.GAME_TITLE
        
    //=======================================================
    // MARK: - Casting de la première équipe
    //=======================================================
        
        var teamId = 0
        var teamName = "AAA_GRRRR!"
        
        Game.teams.append(Team(gameName: gameName, teamId: teamId, teamName: teamName))
        
        // 3 append du tableau Characters
        Game.teams[0].characters.append(Character(gameName: gameName, teamId: teamId, teamName: teamName, characterId: 0, characterName: "A1"))
        Game.teams[0].characters.append(Character(gameName: gameName, teamId: teamId, teamName: teamName, characterId: 1, characterName: "A2"))
        Game.teams[0].characters.append(Character(gameName: gameName, teamId: teamId, teamName: teamName, characterId: 2, characterName: "A3"))

        Game.teams[0].characters[0].role = Role_1()
        Game.teams[0].characters[1].role = Role_2()
        Game.teams[0].characters[2].role = Healer()

//        if displayColoredBalls {
//            print("Création de l'équipe 0 - characters 0\n")
//            Game.teams[0].characters[0].displayFromCurrentClass()
//            print("Création de l'équipe 0 - characters 1\n")
//            Game.teams[0].characters[1].displayFromCurrentClass()
//            print("Création de l'équipe 0 - characters 2\n")
//            Game.teams[0].characters[2].displayFromCurrentClass()
//        }
        
        print("  Récapitulation :")
        Game.teams[0].displayTheCharacteristicsOfAllCharacterOfTheTeam()
        
    //=======================================================
    // MARK: - Casting de la seconde équipe
    //=======================================================
        
        
        teamId = 1
        teamName = "ZZZ_GRRR!"
        
        Game.teams.append(Team(gameName: gameName, teamId: teamId, teamName: teamName))
        
    /// 3 appends du tableau Characters
        Game.teams[1].characters.append(Character(gameName: gameName, teamId: teamId, teamName: teamName, characterId: 0, characterName: "Z1"))
        Game.teams[1].characters.append(Character(gameName: gameName, teamId: teamId, teamName: teamName, characterId: 1, characterName: "Z2"))
        Game.teams[1].characters.append(Character(gameName: gameName, teamId: teamId, teamName: teamName, characterId: 2, characterName: "Z3"))

        Game.teams[1].characters[0].role = Role_3()
        Game.teams[1].characters[1].role = Role_4()
        Game.teams[1].characters[2].role = Healer()

        print("\(constants.TIRETS)")
        
//        if displayColoredBalls {
//            print("Création de l'équipe 1 - characters 0\n")
//            Game.teams[1].characters[0].displayFromCurrentClass()
//            print("Création de l'équipe 1 - characters 1\n")
//            Game.teams[1].characters[1].displayFromCurrentClass()
//            print("Création de l'équipe 1 - characters 2\n")
//            Game.teams[1].characters[2].displayFromCurrentClass()
//        }
        
        print("  Récapitulation :")
        Game.teams[1].displayTheCharacteristicsOfAllCharacterOfTheTeam()
        
    } /// end of : func mainCastingAuto() {
    
    
} // end of : extension Game





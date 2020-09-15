//
//  Game.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

/// Class description
class Game {
    
    // MARK: - Global portability properties in the game
    
    // Member description
    let gameName: String
    
    init(gameName: String) {
        self.gameName = gameName
    }
    
    // MARK: - : Main function of the game
    
    func mainGame() {
        
        //Game Tittle
        titleOfGame()
        
        if initAuto {
            /// extensionCastingAuto
            mainCastingAuto()
        } else {
            /// extensionCasting
            mainCasting()
        }
        
        /// extentionRunFight
        mainFight()
        
        /// extentionEndOfGame
        endOfGame()
        ///
    } // end of : func startGame()
    
    // MARK: - Titles Start Game
    
    fileprivate func titleOfGame() {
        // titles
        print("\n\(constants.LINE)")
        print("                       \(self.gameName)")
        print("\n\(constants.LINE)\n")
    }
    
//    func displayFromCurrentClass() {
//        print(" \n🔴 Display from class Game")
//        print("🔴 self.gameName : \"\(self.gameName)\"\n")
//    }
    
    
    // MARK: - 1 - configuration of players, teams, characters
    func mainCasting() {
        
//        if displayColoredBalls {
//            displayFromCurrentClass()
//        }
        
//        var anyTeam: Team
        for playerIndex in 0...constants.DEFAULT_PLAYERS_NUMBER - 1 {
            
            Game.teams.append(creationOfTeams(playerIndex: playerIndex))
            
//            if displayColoredBalls {
//                Game.teams[playerIndex].displayFromCurrentClass()
//            }
            
            var anyCharacter: Character
            for characterIndex in 0...constants.DEFAULT_CHARACTERS_NUMBER - 1 {
                anyCharacter = Game.teams[playerIndex].creationCharacter(characterIndex: characterIndex)
                // to respect the concept of class responsibility
                anyCharacter.createRole()
                // to respect the concept of class responsibility
                Game.teams[playerIndex].appendNewCharacterOfTheTeam(newCharacter: anyCharacter)
                
//                if displayColoredBalls {
//                    anyCharacter.displayFromCurrentClass()
//                }
            } /// for characterIndex in 0...constants.DEFAULT_CHARACTERS_NUMBER
            
            // to respect the concept of class responsibility
            print("\n  Récapitulation de la composition :")
            Game.teams[playerIndex].displayTheCharacteristicsOfAllCharacterOfTheTeam()
            
        } // end of :for playerIndex in 0...constants.DEFAULT_PLAYERS_NUMBER
        
    } // func mainCasting() {
    
    ///=======================================
    // MARK: - creation of player instances
    ///=======================================
    func creationOfTeams(playerIndex: Int) -> Team {
        print("\n   JOUEUR NUMERO \(playerIndex+1) -> Quel sera le nom de ton équipe ? ", terminator: "")
        let returnedData = Game.choiceNames()
        return Team(gameName: gameName, teamId: playerIndex, teamName: returnedData)
    } // end of : func creationOfTeams
    
    
    // MARK: - SECTION for runFight functions
    
    /// This section manages the whole "assaults" part of the game.
    /// A "while" loop will rotate until one of the 2 teams is no longer alive.
    ///
    /// - Returns the statics variables "winningTeam" and "losingTeam".
    func mainFight() {
        
        // creation of instance variables initialized by default.
        var attackingTeam: Team = Game.teams[0] //arbitrary creation and initialization
        var targetTeam: Team = Game.teams[0] //arbitrary creation and initialization
        
        var attackingCharacter: Character = Game.teams[0].characters[0] //arbitrary creation and initialization
        var targetCharacter: Character = Game.teams[0].characters[0] //arbitrary creation and initialization
        
        var winningTeam: Team = Game.teams[0] //arbitrary creation and initialization
        var losingTeam: Team = Game.teams[0] //arbitrary creation and initialization
        
        // fight loop
        repeat {
            // assault counter
            Game.counter += 1
            // round title
            print("\n\(constants.LINE)")
            print("            ⚔️👊 Assaut numéro \(Game.counter)")
            print("\n\(constants.LINE)")
            
            /// "heads or tails" for which team attacks first
            if Game.counter == 1 {
                ///random team witch start lthe play randomly
                (attackingTeam, targetTeam) = attackingTeam.firstRandomRound()
            } else {
                ///swap teams after first round
                (attackingTeam, targetTeam) = winningTeam.switchLosingTeamToAttackingTeam(losingTeam: losingTeam)
            }
            
            // MARK: - Choose the Attacking Character:
            attackingCharacter = attackingTeam.choiceOfOneTeamCharactercontext(context: "attaquante")
            
            // in Case of healer choice, we have to go to a special treatment.
            if attackingCharacter.role.roleName == constants.HEALER_ROLE {
                // case of Healer, we have to go to his special treatment
                // instanciation de la classe HealerTreatmentProcess
                let healerSection = HealerSection(teamConcerned: attackingTeam, teamNotConcerned: targetTeam, healerChoosen: attackingCharacter)
                // appel de la fonction treatmentProcessOfTheHealer de cette instance
                (winningTeam, losingTeam) = healerSection.treatmentProcessOfTheHealer()
            } /// end of :  if attackingCharacter.role.roleName == constants.GREY_ROLE
            
            // if the first attacker isn't an healer with a special treatment
            if attackingCharacter.role.roleName != constants.HEALER_ROLE {
                // MARK: - Choose the Target Character:
                targetCharacter = targetTeam.choiceOfOneTeamCharactercontext(context: "attaquée")
            } // end of : if attackingCharacter.role.roleName != constants.HEALER_ROLE {
            
            // in Case of healer choice, we have to go to a special treatment.
            if targetCharacter.role.roleName == constants.HEALER_ROLE {
                // case of Healer, we have to go to his special treatment
                 // instanciation de la classe HealerTreatmentProcess
                 let healerSection = HealerSection(teamConcerned: targetTeam, teamNotConcerned: attackingTeam, healerChoosen: targetCharacter)
                 // appel de la fonction treatmentProcessOfTheHealer de cette instance
                 (winningTeam, losingTeam) = healerSection.treatmentProcessOfTheHealer()
            } /// end of : if targetCharacter.role.roleName == constants.GREY_ROLE
            
            // MARK: - Fight section
            
            // Run the assault func WITH THE TWO CHARACTERS selected
            if attackingCharacter.role.roleName != constants.HEALER_ROLE && targetCharacter.role.roleName != constants.HEALER_ROLE {
                
                // instanciation de la classe HealerTreatmentProcess
                let fightSection = FightSection(attackingCharacter: attackingCharacter, targetCharacter: targetCharacter)
                // appel de la fonction treatmentProcessOfTheHealer de cette instance
                (winningTeam, losingTeam) = fightSection.launchOfTheAssault()
            }
            
        } while Game.teams[0].checkIfTeamIsAlive() && Game.teams[1].checkIfTeamIsAlive()
        // run until the two teams have at least one survivor
    } // end of : func runFight() {
    
    
    // MARK: - End of game fucntions
    
    
    //End of the game, display fight results and stats
    func endOfGame() {
        fightResults()
        displayFightStats()
    } // end of : func endOfGame()
    
    func fightResults() {
        print("\n             ❌ La partie est terminée ❌\n")
        
        if  Game.teams[0].checkIfTeamIsAlive(){
            Game.winner = 0
            Game.looser = 1
        } else {
            Game.winner = 1
            Game.looser = 0
        }// end of : if  teams[0].checkIfTeamIsAlive(){
        print("\(constants.SUB_LINE)")
        print("     🏆 L'équipe gagnante est \"\(Game.teams[Game.winner].teamName)\" en \(Game.counter) tours.\n\n     ☠️ L'équipe perdante est \(Game.teams[Game.looser].teamName)👎🏽👎🏽👎🏽\n")
    } // end of :fileprivate  func fightResults() {
    
    func displayFightStats() {
        
        print("\(constants.SUB_LINE)\n               Inventaire des effectifs résiduels : \n")
        
        Game.teams[Game.winner].workForcesInventory()
        print("")
        Game.teams[Game.looser].workForcesInventory()
        
        print("\(constants.SUB_LINE)")
        
    } // end of : battleTeamStats()
    
} // end of : class Game












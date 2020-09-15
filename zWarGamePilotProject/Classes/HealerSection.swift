//
//  HealerProcess.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 28/07/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

class HealerSection {
    
    fileprivate var teamConcerned: Team
    fileprivate var teamNotConcerned: Team
    fileprivate var healerChoosen: Character
    
    fileprivate var characterSelectedToHeal: Character = Game.teams[0].characters[0] // arbitrary initialization
    
    init (teamConcerned: Team, teamNotConcerned: Team, healerChoosen: Character){
        self.teamConcerned = teamConcerned
        self.teamNotConcerned = teamNotConcerned
        self.healerChoosen = healerChoosen
    }
    
    internal func treatmentProcessOfTheHealer() -> (Team, Team) {
        
        var local_WinningTeam: Team = Game.teams[0]
        var local_LosingTeam: Team = Game.teams[0]
        
        print("\n     👺 C'est \"\(healerChoosen.characterName)\" - \"\(healerChoosen.role.roleName)\" de l'équipe  \(healerChoosen.teamId + 1) - \"\(healerChoosen.teamName)\" qui a été choisi !!!\n")
        print("        Mais qui soigner dans l'équipe ?\n")
        
        displayThePartnersToBeTreated()
        
        // check if the healer stays alone?
        let theHealerStaysAlone = isTheHealerStaysAlone()
        if theHealerStaysAlone {
            theHealerStaysAloneAndFlees()
            local_WinningTeam = teamNotConcerned
            local_LosingTeam = teamConcerned
        } else {
            let characterSelectedToHeal = selectCharacterToHeal()
            
            let isTheChoiceValid: Bool = isThisCareChoiceValid(characterSelectedToHeal: characterSelectedToHeal)
            
            if isTheChoiceValid {
                validCareChoice(characterSelectedToHeal: characterSelectedToHeal)
                local_WinningTeam = teamConcerned
                local_LosingTeam = teamNotConcerned
            } else {
                notValidCareChoice()
                local_WinningTeam = teamNotConcerned
                local_LosingTeam = teamConcerned
            } //end of : if isTheChoiceValid {
        } // end of : let isTheHealerAlone = attakingTeam.checkIfTheHealerIsAlone()
        return (local_WinningTeam, local_LosingTeam)
    } // end of : let isTheHealerAlone = attakingTeam.checkIfTheHealerIsAlone()
    
    
    
    // MARK: - Healing section
    fileprivate func displayThePartnersToBeTreated() {
        
        for index in 0 ... constants.DEFAULT_CHARACTERS_NUMBER - 1 {
            print("         \(index+1) | \(teamConcerned.characters[index].characterName) \(teamConcerned.characters[index].role.roleName) \(teamConcerned.characters[index].role.life)\\\(teamConcerned.characters[index].role.maxLife)")
        } // end of :  for index in 0... constants.DEFAULT_CHARACTERS_NUMBER - 1 {
    } // end of :  displayPartnersToHeal(healerTeam: Team) {
    
    fileprivate func selectCharacterToHeal() -> Character {
        var selectedFighter: Character = teamConcerned.characters[0]
        var choiceIsOk: Bool = true
        
        repeat {
            print("")
            print("         Qui veux-tu soigner ? ", terminator: "")
            if let inputChoice = readLine() {
                if inputChoice == "1" || inputChoice == "2" || inputChoice == "3" {
                    guard let intInputChoice = Int(inputChoice) else { fatalError() }
                    let index = intInputChoice - 1
                    selectedFighter = teamConcerned.characters[index]
                    choiceIsOk = true
                }else{
                    choiceIsOk = false
                    print("⛔️ Erreur, saisissez un chiffre entre 1 et \(teamConcerned.characters.count). Recommencez !")
                } // end of : if inputChoice == "1"
            }// end of : if let choice = readLine()
        } while choiceIsOk == false // end of : if let choice = readLine() {
        return selectedFighter
    } // end of func selectCharacterToHeal()
    
    
    fileprivate func isTheHealerStaysAlone()-> Bool {
        var numberOfCharacterDead: Int = 0
        teamConcerned.characters.forEach { (character) in
            // nested tests because only one solution is possible
            if character.role.roleName != constants.HEALER_ROLE {
                if character.role.life <= 0 {
                    numberOfCharacterDead += 1
                } // end of : if characterRole.name == 0 {
            } // end of : nested tests because only one solution is possible
        } // end of : team.characters.forEach { (character) in
        return  numberOfCharacterDead == constants.DEFAULT_CHARACTERS_NUMBER-1 ? true : false
    } // end of : private func isTheHealerAlone
    
    
    // MARK: - validCareChoice
    // A Healer cannot to heal dead fighter or himeself
    fileprivate func isThisCareChoiceValid (characterSelectedToHeal: Character) -> Bool {
        if characterSelectedToHeal.role.roleName == constants.HEALER_ROLE {
            print("\n      🛂 Le soigneur ne peut pas se soigner lui même !")
            return false
        } else if characterSelectedToHeal.role.life == 0 {
            print("\n      🛂 Le soigneur s'est porté au secours d\'un guerrier déjà mort !")
            return false
        } else if characterSelectedToHeal.role.life == characterSelectedToHeal.role.maxLife {
            print("\n      🛂 Le soigneur s'est porté au secours d\'un guerrier en pleine force !")
            return false
        } else {
            return true
        } // end of :  if characterSelectedToHeal.name == constants.HEALER_ROLE {
    } // end of : func validCareChoice
    
    fileprivate func validCareChoice(characterSelectedToHeal: Character) {
        
        // healing execution
        characterSelectedToHeal.role.life = characterSelectedToHeal.role.life + healerChoosen.role.roleWeapon.effect
        
        // verification of being less than or equal to the local_CharacterSelectedToHeal's maximum life
        if characterSelectedToHeal.role.life > characterSelectedToHeal.role.maxLife {
            characterSelectedToHeal.role.life = characterSelectedToHeal.role.maxLife
        }
        print("\n     👺 Après les soins prodigués par \"\(healerChoosen.characterName)\", \"\(healerChoosen.role.roleName)\" de l'équipe \"\(healerChoosen.teamName)\"\n        son compère \"\(characterSelectedToHeal.characterName)\", \"\(characterSelectedToHeal.role.roleName)\" a maintenant  \(characterSelectedToHeal.role.life) points de vie 💪🏼")
    }
    
    fileprivate func notValidCareChoice() {
        print("\n      👺 Désolé, mais ce choix n'est pas valide,\n\n         L'équipe \"\(teamConcerned.teamName)\" perd son tour ! 😩\n")
    }
    
    // MARK: - theHealerBeAloneFlees
    fileprivate func theHealerStaysAloneAndFlees() {
        
        // Last survivor, the healer is declared dead. He cannot fight, so we declare the end of the game
        self.theHealerChoosenIsDeclaredDead()
        
        print ("\n     🔥 Aie... aie... aie... Resté seul, \n        \"\(healerChoosen.characterName)\" - \"\(healerChoosen.role.roleName)\" ne peut pas se battre et donc, ne peut plus rien faire...\n        il explose en boule de feu, et son équipe, \"\(teamConcerned.teamName)\", est décimée ! 👎🏻\n")
        
        // if the wizzard is dead, he's forfeit
        
    } // end of :func theHealerBeAloneFlees() {
    
    
    // MARK: -  CharacterIsDeclaredDead
    // a character is declared dead, he's out !
    fileprivate func theHealerChoosenIsDeclaredDead() {
        // Last survivor, the HEALER is declared dead. He cannot fight, so we declare him dead.
        healerChoosen.role.life = 0
    } // end of : func  characterIsDeclaredDead() {
    
} // Class

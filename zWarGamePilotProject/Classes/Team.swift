//
//  Team.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

class Team : Game {
    
    // MARK: -  Properties and initialization

        var teamId:Int
        var teamName: String
    
        var characters: [Character] = []
        
        init(gameName: String, teamId: Int, teamName: String) {
            self.teamId = teamId
            self.teamName = teamName
            super.init(gameName: gameName)
        }
    
    override func displayFromCurrentClass() {
        super.displayFromCurrentClass()
        print("    🟢 02 display from class Team")
        print("    🟢 02 self.teamId : \(self.teamId)")
        print("    🟢 02 self.teamName : \(self.teamName)\n")
    }
    
    
                        // MARK: - Create characters for each team
    // Setting Teams
    func creationCharacter(characterIndex: Int) -> Character {
        print("\n   Équipe \(self.teamName) : Désignation des combattants\n")
        print("      Joueur numéro \(self.teamId+1) - \"\(self.teamName)\"\n\n      Nomination du guerrier numéro \(characterIndex + 1) :\n")
        print("      Quel est son nom ? ", terminator: "")
        let returnedData = Game.choiceNames()
        let anyCharacter = Character(gameName: self.gameName, teamId: self.teamId, teamName: self.teamName, characterId: characterIndex, characterName: returnedData)
        return anyCharacter
    } // end of : func setUpCharacters() {

    func displayTheCharacteristicsOfAllCharacterOfTheTeam() {
        print("\n  Équipe numéro \"\(teamId + 1)\" - \"\(teamName)\"\n")
        for characterIndex in 0 ... constants.DEFAULT_CHARACTERS_NUMBER-1 {
            let sign = characters[characterIndex].role.roleWeapon.effect > 0 ? "+" : ""
            print("  \(characterIndex+1) : \"\(characters[characterIndex].characterName)\" - \"\(characters[characterIndex].role.roleName)\" - \(characters[characterIndex].role.life)\\\(characters[characterIndex].role.maxLife) points de vie - \"\(characters[characterIndex].role.roleWeapon.weaponName)\" - impact : \(sign)\(characters[characterIndex].role.roleWeapon.effect) points de vie à la victime.")
        }// end of :  for characterIndex in 0 ... constants.DEFAULT_CHARACTERS_NUMBER - 1 {
        print("")
    } // end of : fileprivate func displayCharactersTeamForFight() {
                        // MARK: - Select Character for fight

    func characterSelection(context: String) -> Character {
//        displayAllCharactersOfTheTeam()
        var selectedCharacter: Character = characters[0]
        var choiceIsOk: Bool = true
        repeat {
            print("\n  👋 Choisissez votre combattant : ", terminator: "")
            if let inputChoice = readLine() {
                if inputChoice == "1" || inputChoice == "2" || inputChoice == "3" {
                    guard let intInputChoice = Int(inputChoice) else { fatalError() }
                    let index = intInputChoice - 1
                    selectedCharacter = self.characters[index]
                    choiceIsOk = selectedCharacter.isTheCharacterStillAlive()
                    if choiceIsOk == false  {
                        print ("  ⛔️ \(selectedCharacter.characterName) est éliminé 💀, choisissez un autre combattant !")
                    }
                }else{
                   choiceIsOk = false
                    print("  ⛔️ Erreur! Vous devez saisir un chiffre entre  \"1\" et \"\(characters.count)\". Essayez à nouveau!")
                } // end of : if inputChoice == "1"
            }// end of : if let choice = readLine()
        } while choiceIsOk == false // end of : if let choice = readLine() {

        
        print("\n  ✅ L'équipe numéro \"\(self.teamId+1)\" - \"\(self.teamName)\", \(context), a choisi comme combattant,")
        selectedCharacter.displayTheCharacteristicsOfOneCharacterOfTheTeam()
        return selectedCharacter
    } // end of func selectCharacterForFight()

                        // MARK: - Check Team is still alive

    func checkIfTeamIsAlive() -> Bool {
        var cumulLife: Int = 0
        characters.forEach { (character) in
            cumulLife += character.role.life > 0 ? 1 : 0
        }
        return cumulLife > 0 ? true : false
    } // end of : func isTeamAlive() -> Bool

                        // MARK: - Healing section
    func displayThePartnersToBeTreated(healerTeam: Team) {

        for index in 0 ... constants.DEFAULT_CHARACTERS_NUMBER - 1 {
            print("         \(index+1) | \(healerTeam.characters[index].characterName) \(healerTeam.characters[index].role.roleName) \(healerTeam.characters[index].role.life)\\\(healerTeam.characters[index].role.maxLife)")
        } // end of :  for index in 0... constants.DEFAULT_CHARACTERS_NUMBER - 1 {
    } // end of :  displayPartnersToHeal(healerTeam: Team) {

     func selectCharacterToHeal() -> Character {
        var selectedFighter: Character = characters[0]
        var choiceIsOk: Bool = true

        repeat {
            print("")
            print("         Qui veux-tu soigner ? ", terminator: "")
            if let inputChoice = readLine() {
                if inputChoice == "1" || inputChoice == "2" || inputChoice == "3" {
                    guard let intInputChoice = Int(inputChoice) else { fatalError() }
                    let index = intInputChoice - 1
                    selectedFighter = self.characters[index]
                    choiceIsOk = true
                }else{
                   choiceIsOk = false
                    print("⛔️ Erreur, saisissez un chiffre entre 1 et \(characters.count). Recommencez !")
                } // end of : if inputChoice == "1"
            }// end of : if let choice = readLine()
        } while choiceIsOk == false // end of : if let choice = readLine() {
        return selectedFighter
    } // end of func selectCharacterToHeal()

    func isTheHealerStaysAlone()-> Bool {
        var numberOfCharacterDead: Int = 0
        self.characters.forEach { (character) in
            // nested tests because only one solution is possible
            if character.role.roleName != constants.HEALER_ROLE {
                if character.role.life <= 0 {
                    numberOfCharacterDead += 1
                } // end of : if characterRole.name == 0 {
            } // end of : nested tests because only one solution is possible
        } // end of : team.characters.forEach { (character) in
        return  numberOfCharacterDead == constants.DEFAULT_CHARACTERS_NUMBER-1 ? true : false
    } // end of : private func isTheHealerAlone

                        // MARK: - Display Status Team ( end of game)

    func workForcesInventory() {
        print("    Équipe numéro \"\(self.teamId+1)\" - \"\(self.teamName)\" :\n")
        for index in 0...constants.DEFAULT_CHARACTERS_NUMBER - 1 {
            print("    \(index + 1) : \(characters[index].characterName) - \(characters[index].role.roleName) - Capital vie : \( characters[index].role.life) sur \( self.characters[index].role.maxLife) points de vie alloués.")
        } // end of : for index in 0...constants.DEFAULT_CHARACTERS_NUMBER - 1 {
        print("")
    } // end of :displayStatusTeam() {
    
    
    func choiceOfOneTeamCharactercontext(context: String) -> Character {
            
            self.displayTheCharacteristicsOfAllCharacterOfTheTeam()

            let returnedCharacter = self.characterSelection(context: context)

            return returnedCharacter
            
        } // fileprivate func choiceOfACharacterInTheAttackingTeam

    // MARK: - First Random Round
    // random event : which team start the first round of the fight ?
    
    func firstRandomRound() -> (Team, Team){
        // counter n°1
        var local_attackingTeam: Team
        var local_targetTeam: Team
        
        let randomValue = Bool.random()
        switch randomValue {
        case true:
            local_attackingTeam = Game.teams[0]
            local_targetTeam = Game.teams[1]
        case false:
            local_attackingTeam = Game.teams[1]
            local_targetTeam = Game.teams[0]
        } // end of: randomValue
        print("\n🎲🎲🎲 Le hasard à désigné l'équipe numéro \(local_attackingTeam.teamId+1) - \(local_attackingTeam.teamName ) comme attaquante.\n" )
        
        return (local_attackingTeam, local_targetTeam)
    } // end of : fileprivate firstRandomRound(teams: [Team]) -> (Team, Team){
    
    
        // MARK: - Switch Losing Team to Attacking Team
         func switchLosingTeamToAttackingTeam(losingTeam: Team) -> (Team, Team) {
            /// the losing team in the last round becomes the attacking team of the new assault
            let local_AttackingTeam = losingTeam
            let local_TargetTeam = self
            print("  🛂 L'équipe numéro \"\(local_AttackingTeam.teamId + 1)\" \"\(local_AttackingTeam.teamName )\" ayant perdu l'assaut numéro \(Game.counter-1), devient l'équipe attaquante!" )
            print("")
            return (local_AttackingTeam, local_TargetTeam)
        } /// end of : fileprivate func switchLosingTeamToAttackingTeam
    
    
    
    
} //end of: class Team

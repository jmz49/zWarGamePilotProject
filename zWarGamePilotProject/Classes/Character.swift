//
//  Character.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

final class Character : Team {
    //
    // MARK: - properties and initialisation
    var characterId: Int
    var characterName: String
    
    var role: Role = Healer()
       
    init(gameName: String, teamId: Int, teamName: String, characterId: Int, characterName: String) {
        self.characterId = characterId
        self.characterName = characterName
        super.init(gameName: gameName, teamId: teamId, teamName: teamName)
    }
    
    override func displayFromCurrentClass() {
        super.displayFromCurrentClass()
        print("        🟣 03 display from class Character")
        print("        🟣 03 self.characterId) : \(self.characterId)")
        print("        🟣 03 self.characterName : \(self.characterName)\n")
        print("          🔸 03 self.role")
        print("          🔸 03 self.role.roleName : \(self.role.roleName)")
        print("          🔸 03 self.role.life : \(self.role.life)")
        print("          🔸 03 self.role.maxLife : \(self.role.maxLife)\n")
        print("            🔺 03 self.role!.weapon")
        print("            🔺 03 self.role.weapon.weaponName : \(self.role.roleWeapon.weaponName)")
        print("            🔺 03 self.role.weapon.effect : \(self.role.roleWeapon.effect)")
        print("")
        print(constants.TIRETS)
    } /// end of : override func displayFromCurrentClass() {
    
    
    func createRole() {
        // variable of input verification
        var isInputOk: Bool
        displayAllRoles()
        repeat {
            print("      \n      Quel role attribuez-vous à \(self.characterName) : ", terminator: "")
            isInputOk = true
            if let inputKeybord = readLine() {
                switch inputKeybord {
                case "1" :
                    role = Role_1()
                case "2" :
                    role = Role_2()
                case "3" :
                    role = Role_3()
                case "4" :
                    role = Role_4()
                case "5" :
                    role = Role_5()
                case "6" :
                    role = Role_6()
                case "7" :
                    role = Healer()
                default:
                    isInputOk = false
                    print("⛔️ Erreur de saisie! Recommencez !\n")
                } // end of : switch role
            } // end of : if let name = readLine()
        } while isInputOk == false
    } // end of : func createRole() {
    
    fileprivate func displayAllRoles() {
        print("")
        print("      1 : \(constants.ROLE_1)\n")
        print("      2 : \(constants.ROLE_2)\n")
        print("      3 : \(constants.ROLE_3)\n")
        print("      4 : \(constants.ROLE_4)\n")
        print("      5 : \(constants.ROLE_5)\n")
        print("      6 : \(constants.ROLE_6)\n")
        print("      7 : \(constants.HEALER_ROLE)")
    }
    
    // MARK: - Display Characteristic's characters
    
    // print character's characteristics
    func displayTheCharacteristicsOfOneCharacterOfTheTeam() {
        let sign = self.role.roleWeapon.effect > 0 ? "+" : ""
        print("     \"\(self.characterName)\", un \"\(self.role.roleName)\" avec \(self.role.life)\\\(self.role.maxLife) points de vie,\n     Action : \"\(self.role.roleWeapon.weaponName)\" avec un impact de \(sign)\(self.role.roleWeapon.effect) points de vie à la victime.\n")
    } // end of : displayCharacteristicsCharacter()
    
    func isTheCharacterStillAlive() -> Bool {
            return role.life > 0 ? true : false
    } // end of: isStillAlive() -> Bool {

    
    // MARK: - Assault
    
    func launchOfTheAssault(targetCharacter: Character) -> (Team, Team) {
        
        let local_WinningTeam: Team
        let local_LosingTeam: Team
        
        // random dodge event
//        #warning("Game.counter == 3")
        if (Game.counter == 3 || Game.counter == 5 || Game.counter >= 7) && Bool.random() {
            (local_WinningTeam, local_LosingTeam) = self.sequencesOfChestAndDodgeAssault(targetCharacter: targetCharacter)
        } else {// end of : if Bool.random() {
            (local_WinningTeam, local_LosingTeam) = self.sequencesOfNormalAssault(targetCharacter: targetCharacter)
        } // end of : if counter == 3 || counter == 5 counter => 7
        return (local_WinningTeam, local_LosingTeam)
    } // end of : func assault(counter: Int)
    
    
    // MARK: - Chest And Dodge Attack Section
    
    // Run func dodge | Random event
    fileprivate func sequencesOfChestAndDodgeAssault(targetCharacter: Character) -> (Team, Team) {
        self.displayAttackAnnouncementGeneric(targetCharacter: targetCharacter)
        
        self.displayChestAndDodgeAnnouncement(targetCharacter: targetCharacter)
        
        // function attack reversed
        self.executionOfAnyTypeOfAssault(from: targetCharacter)
        
        // exit of the real fight
        self.displayChestAndDodgeExit(targetCharacter: targetCharacter)
        
        let local_WinningTeam = Game.teams[targetCharacter.teamId]
        let local_LosingTeam = Game.teams[self.teamId]
        
        return (local_WinningTeam, local_LosingTeam)
    } // end of: func dodge(attackingCharacter: Character, targetCharacter: Character) {
    
    fileprivate func displayAttackAnnouncementGeneric(targetCharacter: Character ) {
        print("\n\(constants.SUB_TIRETS)      ⚔️👊 GO !\n\(constants.SUB_TIRETS)")
        print("      🛂 Le combat va avoir lieu entre :\n         - l'attaquant \"\(self.characterName)\", un \"\(self.role.roleName)\" de l'équipe \"\(self.teamName)\", avec \(self.role.life)\\\(self.role.maxLife) points de vie,\n         - contre sa cible \"\(targetCharacter.characterName)\", un \"\(targetCharacter.role.roleName)\" de l'équipe \"\(targetCharacter.teamName)\", avec \(targetCharacter.role.life)\\\(targetCharacter.role.maxLife) points de vie,\n" )
        
        print("      ⚔️⚔️⚔️")
        print("      Bim... Bam... Boum... Aie!")
        print("      ⚔️⚔️⚔️\n")
    } // end of :  func displayFightAnnouncement(...
    
    fileprivate func displayChestAndDodgeAnnouncement(targetCharacter: Character){
        
        // save the current attackingCharacter.role.life in the variable Game.memLife
        // to later remember how many hit points the attackingCharacter actually lost.
        // Game.memLife is used in the chestAndDodgeExit function to print the result of the assault.
        Game.memLife = self.role.life
        
        //magicWeapon toggle
        // 1 save current weapon for later return
        Game.toggleWeapon = targetCharacter.role.roleWeapon
        // 2 temporary assignment of the magic weapon
        targetCharacter.role.roleWeapon = MagicWeapon()

        // At this point, we are OK for fight, but ...
        
        print("      🎲  Mais... surprise...  ho la la...  😱😱😱\n      🎲  \"\(targetCharacter.characterName)\", \"\(targetCharacter.role.roleName)\" de l'équipe \"\(targetCharacter.teamName)\", attaqué, trébuche sur un coffre,\n      🎲  et une arme \"\(targetCharacter.role.roleWeapon.weaponName)\", inattendue et dévastatrice apparaît ?!?!\n      🎲  Cela lui permet 1) d'esquiver son attaquant \"\(self.characterName)\", \"\(self.role.roleName)\" de l'équipe \"\(self.teamName)\" et 2) de le fracasser !")
        print("")
    } // end of : func displayDodgeAnnouncement
    
    fileprivate func displayChestAndDodgeExit(targetCharacter: Character) {
        
        var endingText: String
        if self.isTheCharacterStillAlive() {
            endingText    = ", auquel il ne reste que  \(self.role.life) points de vie.\n"
        } else {
            endingText    = ", lequel est éliminé 👎🏻\n"
        }
        print("      🛂 Resultat de l'assaut numéro \(Game.counter) :")
        print("         Grâce à une esquive et au coffre contenant une arme secrète,\n         - l'attaqué \"\(targetCharacter.characterName)\", un \"\(targetCharacter.role.roleName)\" de l'équipe \(targetCharacter.teamId+1) - \"\(targetCharacter.teamName)\", a retiré les derniers \(Game.memLife) points de vie à\n         - l'attaquant \"\(self.characterName)\", un  \"\(self.role.roleName)\" de l'équipe \(self.teamId+1) - \"\(self.teamName)\"\(endingText)")
        
        //reassignment of the initial weapon stored in the variable toggleWeapon
        targetCharacter.role.roleWeapon = Game.toggleWeapon
        
    } // end of : func fightExit
    
    // MARK: - Normal Attack Section
    fileprivate func sequencesOfNormalAssault(targetCharacter: Character) -> (Team, Team) {
        
        displayAttackAnnouncementGeneric(targetCharacter: targetCharacter)
        
        targetCharacter.executionOfAnyTypeOfAssault(from: self)
        
        // fight Bim... Bam... Boum... !
        
        
        // exit of the normal assault
        displayNormalAttackExit(targetCharacter: targetCharacter)
        
        let local_WinningTeam = Game.teams[self.teamId]
        let local_LosingTeam = Game.teams[targetCharacter.teamId]
        
        return (local_WinningTeam, local_LosingTeam)
    } // end of : func fight
    
    fileprivate func displayNormalAttackExit(targetCharacter: Character){
        
        var endingText: String
        if targetCharacter.isTheCharacterStillAlive() {
            endingText    = " auquel il ne reste que \(targetCharacter.role.life)\\\(targetCharacter.role.maxLife) points de vie.\n"
        } else {
            endingText    = " lequel est éliminé 👎🏻\n"
        }
        print("      🛂 Resultat de l'assaut numéro \(Game.counter) :")
        print("         - L'attaquant \"\(self.characterName)\", un \"\(self.role.roleName)\" de l'équipe \(self.teamId+1) - \"\(self.teamName)\", a retiré \(self.role.roleWeapon.effect) points de vie à :")
        print("         - l'attaqué \"\(targetCharacter.characterName)\", un \"\(targetCharacter.role.roleName)\" de l'équipe \(targetCharacter.teamId+1) - \"\(targetCharacter.teamName)\",\(endingText)")
    } // end of : func fightExit
    
    func executionOfAnyTypeOfAssault (from fighter: Character) {
        
        // unique instruction concretizing the virtual fight
        // PLEASE NOTE : This is an addition of negative relative numbers (effect)
        self.role.life = self.role.life + fighter.role.roleWeapon.effect
        
        // in case of negative roleLife
        if role.life < 0 {
            role.life = 0
        } // end of: if
    } // end of : func attack

    
    // MARK: - Healing Section
    
    func treatmentProcessOfTheHealer(opponentTeam: Team) -> (Team, Team) {
        
        // arbitrary initializations to please Swift
        var local_WinningTeam: Team = Game.teams[0]
        var local_LosingTeam: Team = Game.teams[0]
        let local_healerTeam = Game.teams[self.teamId]
        
        print("\n     👺 C'est \"\(self.characterName)\" - \"\(self.role.roleName)\" de l'équipe  \(self.teamId + 1) - \"\(self.teamName)\" qui a été choisi !!!\n")
        print("        Mais qui soigner dans l'équipe ?\n")
        
        local_healerTeam.displayThePartnersToBeTreated(healerTeam: local_healerTeam)
        
        // check if the healer stays alone?
        let theHealerStaysAlone = local_healerTeam.isTheHealerStaysAlone()
        if theHealerStaysAlone {
            self.theHealerStaysAloneAndFlees()
            local_WinningTeam = opponentTeam
            local_LosingTeam = local_healerTeam
        } else {
            
            let local_CharacterSelectedToHeal = local_healerTeam.selectCharacterToHeal()

            let isTheChoiceValid: Bool = isThisCareChoiceValid(characterSelectedToHeal: local_CharacterSelectedToHeal)
            if isTheChoiceValid {
                local_CharacterSelectedToHeal.validCareChoice(healerSelected: self)
                local_WinningTeam = local_healerTeam
                local_LosingTeam = opponentTeam
            } else {
                notValidCareChoice(healerSelected: self)
                local_WinningTeam = opponentTeam
                local_LosingTeam = local_healerTeam
            } //end of : if isTheChoiceValid {
        } // end of : let isTheHealerAlone = attakingTeam.checkIfTheHealerIsAlone()
        return (local_WinningTeam, local_LosingTeam)
    } // end of : func treatmentProcessOfTheHealer
    
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
            print("\n      🛂 Le soigneur s'est porté au secours d\'un guerrier en pleine forve !")
            return false
        } else {
            return true
        } // end of :  if characterSelectedToHeal.name == constants.HEALER_ROLE {
    } // end of : func validCareChoice
    
    
    fileprivate func validCareChoice(healerSelected: Character) {
        
        // healing execution
        self.role.life = self.role.life + healerSelected.role.roleWeapon.effect
        
        // verification of being less than or equal to the local_CharacterSelectedToHeal's maximum life
        if self.role.life > self.role.maxLife {
            self.role.life = self.role.maxLife
        }
        print("\n     👺 Après les soins prodigués par \"\(healerSelected.characterName)\", \"\(healerSelected.role.roleName)\" de l'équipe \"\(healerSelected.teamName)\"\n        son compère \"\(self.characterName)\", \"\(self.role.roleName)\" a maintenant  \(self.role.life) points de vie 💪🏼")

    }
    
    fileprivate func notValidCareChoice(healerSelected: Character) {
        print("\n      👺 Désolé, mais ce choix n'est pas valide,\n         L'équipe \"\(healerSelected.teamName)\" perd son tour ! 😩\n")
    }
    
    // MARK: - theHealerBeAloneFlees
    func theHealerStaysAloneAndFlees() {
        
        // Last survivor, the healer is declared dead. He cannot fight, so we declare the end of the game
        self.characterIsDeclaredDead()
        
        print ("\n     🔥 Aie... aie... aie... Resté seul, \n        \"\(self.characterName)\" - \"\(self.role.roleName)\" ne peut pas se battre et donc, ne peut plus rien faire...\n        il explose en boule de feu, et son équipe, \"\(self.teamName)\", est décimée ! 👎🏻\n")
        
        // if the wizzard is dead, he's forfeit
        
    } // end of :func theHealerBeAloneFlees() {
    
    
    // MARK: -  CharacterIsDeclaredDead
    // a character is declared dead, he's out !
    func characterIsDeclaredDead() {
        // Last survivor, the HEALER is declared dead. He cannot fight, so we declare him dead.
        role.life = 0
    } // end of : func  characterIsDeclaredDead() {
    
}// end of class Character


//
//  FightSection.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 29/07/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

class FightSection {
    
    var attackingCharacter: Character
    var targetCharacter: Character
    var local_WinningTeam = Game.teams[0] // arbitrary initialization
    var local_LosingTeam = Game.teams[0] // arbitrary initialization
    
    init (attackingCharacter: Character, targetCharacter: Character){
        self.attackingCharacter = attackingCharacter
        self.targetCharacter = targetCharacter
    }
    
    
    // MARK: - Assault
    
    func launchOfTheAssault() -> (Team, Team) {
        
        // random dodge event
        //        #warning("Game.counter == 3")
        if (Game.counter == 3 || Game.counter == 5 || Game.counter >= 7) && Bool.random() {
            (local_WinningTeam, local_LosingTeam) = sequencesOfChestAndDodgeAssault()
        } else {// end of : if Bool.random() {
            (local_WinningTeam, local_LosingTeam) = sequencesOfNormalAssault()
        } // end of : if counter == 3 || counter == 5 counter => 7
        return (local_WinningTeam, local_LosingTeam)
    } // end of : func assault(counter: Int)
    
    
    // MARK: - Chest And Dodge Attack Section
    
    // Run func dodge | Random event
    fileprivate func sequencesOfChestAndDodgeAssault() -> (Team, Team) {
        self.displayAttackAnnouncementGeneric(targetCharacter: targetCharacter)
        
        self.displayChestAndDodgeAnnouncement(targetCharacter: targetCharacter)
        
        // function attack reversed
        self.executionOfAnyTypeOfAssault(winner: targetCharacter, looser: attackingCharacter)
        
        // exit of the real fight
        self.displayChestAndDodgeExit(targetCharacter: targetCharacter)
        
        let local_WinningTeam = Game.teams[targetCharacter.teamId]
        let local_LosingTeam = Game.teams[attackingCharacter.teamId]
        
        return (local_WinningTeam, local_LosingTeam)
    } // end of: func dodge(attackingCharacter: Character, targetCharacter: Character) {
    
    fileprivate func displayAttackAnnouncementGeneric(targetCharacter: Character ) {
        print("\n\(constants.SUB_TIRETS)      ⚔️👊 GO !\n\(constants.SUB_TIRETS)")
        print("      🛂 Le combat va avoir lieu entre :\n         - l'attaquant \"\(attackingCharacter.characterName)\", un \"\(attackingCharacter.role.roleName)\" de l'équipe \"\(attackingCharacter.teamName)\", avec \(attackingCharacter.role.life)\\\(attackingCharacter.role.maxLife) points de vie,\n         - contre sa cible \"\(targetCharacter.characterName)\", un \"\(targetCharacter.role.roleName)\" de l'équipe \"\(targetCharacter.teamName)\", avec \(targetCharacter.role.life)\\\(targetCharacter.role.maxLife) points de vie,\n" )
        
        print("      ⚔️⚔️⚔️")
        print("      Bim... Bam... Boum... Aie!")
        print("      ⚔️⚔️⚔️\n")
    } // end of :  func displayFightAnnouncement(...
    
    fileprivate func displayChestAndDodgeAnnouncement(targetCharacter: Character){
        
        // save the current attackingCharacter.role.life in the variable Game.memLife
        // to later remember how many hit points the attackingCharacter actually lost.
        // Game.memLife is used in the chestAndDodgeExit function to print the result of the assault.
        Game.memLife = attackingCharacter.role.life
        
        //magicWeapon toggle
        // 1 save current weapon for later return
        Game.toggleWeapon = targetCharacter.role.roleWeapon
        // 2 temporary assignment of the magic weapon
        targetCharacter.role.roleWeapon = MagicWeapon()
        
        // At this point, we are OK for fight, but ...
        
        print("      🎲  Mais... surprise...  ho la la...  😱😱😱\n      🎲  \"\(targetCharacter.characterName)\", \"\(targetCharacter.role.roleName)\" de l'équipe \"\(targetCharacter.teamName)\", attaqué, trébuche sur un coffre,\n      🎲  et une arme \"\(targetCharacter.role.roleWeapon.weaponName)\", inattendue et dévastatrice apparaît ?!?!\n      🎲  Cela lui permet 1) d'esquiver son attaquant \"\(attackingCharacter.characterName)\", \"\(attackingCharacter.role.roleName)\" de l'équipe \"\(attackingCharacter.teamName)\" et 2) de le fracasser !")
        print("")
    } // end of : func displayDodgeAnnouncement
    
    fileprivate func displayChestAndDodgeExit(targetCharacter: Character) {
        
        var endingText: String
        if isTheCharacterStillAlive(anyCharacter: attackingCharacter) {
            endingText    = ", auquel il ne reste que  \(attackingCharacter.role.life) points de vie.\n"
        } else {
            endingText    = ", lequel est éliminé 👎🏻\n"
        }
        print("      🛂 Resultat de l'assaut numéro \(Game.counter) :")
        print("         Grâce à une esquive et au coffre contenant une arme secrète,\n         - l'attaqué \"\(targetCharacter.characterName)\", un \"\(targetCharacter.role.roleName)\" de l'équipe \(targetCharacter.teamId+1) - \"\(targetCharacter.teamName)\", a retiré les derniers \(Game.memLife) points de vie à\n         - l'attaquant \"\(attackingCharacter.characterName)\", un  \"\(attackingCharacter.role.roleName)\" de l'équipe \(attackingCharacter.teamId+1) - \"\(attackingCharacter.teamName)\"\(endingText)")
        
        //reassignment of the initial weapon stored in the variable toggleWeapon
        targetCharacter.role.roleWeapon = Game.toggleWeapon
        
    } // end of : func fightExit
    
    // MARK: - Normal Attack Section
    fileprivate func sequencesOfNormalAssault() -> (Team, Team) {
        
        displayAttackAnnouncementGeneric(targetCharacter: targetCharacter)
        
        executionOfAnyTypeOfAssault(winner: attackingCharacter, looser: targetCharacter)
        
        // fight Bim... Bam... Boum... !
        
        
        // exit of the normal assault
        displayNormalAttackExit(targetCharacter: targetCharacter)
        
        let local_WinningTeam = Game.teams[attackingCharacter.teamId]
        let local_LosingTeam = Game.teams[targetCharacter.teamId]
        
        return (local_WinningTeam, local_LosingTeam)
    } // end of : func fight
    
    fileprivate func displayNormalAttackExit(targetCharacter: Character){
        
        var endingText: String
        if isTheCharacterStillAlive(anyCharacter: targetCharacter) {
            endingText    = " auquel il ne reste que \(targetCharacter.role.life)\\\(targetCharacter.role.maxLife) points de vie.\n"
        } else {
            endingText    = " lequel est éliminé 👎🏻\n"
        }
        print("      🛂 Resultat de l'assaut numéro \(Game.counter) :")
        print("         - L'attaquant \"\(attackingCharacter.characterName)\", un \"\(attackingCharacter.role.roleName)\" de l'équipe \(attackingCharacter.teamId+1) - \"\(attackingCharacter.teamName)\", a retiré \(attackingCharacter.role.roleWeapon.effect) points de vie à :")
        print("         - l'attaqué \"\(targetCharacter.characterName)\", un \"\(targetCharacter.role.roleName)\" de l'équipe \(targetCharacter.teamId+1) - \"\(targetCharacter.teamName)\",\(endingText)")
    } // end of : func fightExit
    
    func executionOfAnyTypeOfAssault(winner: Character, looser: Character) {
        
        // unique instruction concretizing the virtual fight
        // PLEASE NOTE : This is an addition of negative relative numbers (effect)
        looser.role.life = looser.role.life + attackingCharacter.role.roleWeapon.effect
        
        // in case of negative roleLife
        if looser.role.life < 0 {
            looser.role.life = 0
        } // end of: if
    } // executionOfAnyTypeOfAssault
    
    func isTheCharacterStillAlive(anyCharacter: Character) -> Bool {
        return anyCharacter.role.life > 0 ? true : false
    } // end of: isStillAlive() -> Bool {

    
} // Class

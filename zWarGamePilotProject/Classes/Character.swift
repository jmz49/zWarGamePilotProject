//
//  Character.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

final class Character {
    //
    // MARK: - properties and initialisation
    let gameName: String
    
    let teamId:Int
    let teamName: String
    
    let characterId: Int
    let characterName: String
    
    var role: Role = Healer() //Healer is arbitrary creation and initialization to abort optionnal problems
       
    init(gameName: String, teamId: Int, teamName: String, characterId: Int, characterName: String) {
        
        self.gameName = gameName
        
        self.teamId = teamId
        self.teamName = teamName
        
        self.characterId = characterId
        self.characterName = characterName
        
        
        //super.init(gameName: gameName, teamId: teamId, teamName: teamName)
    }
    
//    override func displayFromCurrentClass() {
//        super.displayFromCurrentClass()
//        print("        🟣 Display from class Character")
//        print("        🟣 self.characterId) : \(self.characterId)")
//        print("        🟣 self.characterName : \(self.characterName)\n")
//        print("          🔸 self.role")
//        print("          🔸 self.role.roleName : \(self.role.roleName)")
//        print("          🔸 self.role.life : \(self.role.life)")
//        print("          🔸 self.role.maxLife : \(self.role.maxLife)\n")
//        print("            🔺 self.role!.weapon")
//        print("            🔺 self.role.weapon.weaponName : \(self.role.roleWeapon.weaponName)")
//        print("            🔺 self.role.weapon.effect : \(self.role.roleWeapon.effect)")
//        print("")
//        print(constants.TIRETS)
//    } /// end of : override func displayFromCurrentClass() {
    
    
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
        print("     \"\(self.characterName)\", un \"\(self.role.roleName)\" avec \(self.role.life)\\\(self.role.maxLife) points de vie,\n     Action : \"\(self.role.roleWeapon.weaponName)\" avec un impact de \(sign)\(self.role.roleWeapon.effect) points de vie pour la victime.\n")
    } // end of : displayCharacteristicsCharacter()
    
} // class



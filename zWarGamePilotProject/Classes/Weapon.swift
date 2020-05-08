//
//  Weapon.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

class Weapon {
    
    let weaponName : String
    var effect: Int
    
    init(weaponName: String, effect: Int) {
        self.weaponName = weaponName
        self.effect = effect
    }//End of init(damage: Int, weaponName: String)
    
}//End of class Weapon

class Weapon1: Weapon {
    init() {
        super.init(weaponName: constants.WEAPON_1, effect: constants.WEAPON_1_EFFECT)
    }
}

class Weapon2: Weapon {
    init() {
        super.init(weaponName: constants.WEAPON_2, effect: constants.WEAPON_2_EFFECT)
    }
}

class Weapon3: Weapon {
    init() {
        super.init(weaponName: constants.WEAPON_3, effect: constants.WEAPON_3_EFFECT)
    }
}

class Weapon4: Weapon {
    init() {
        super.init(weaponName: constants.WEAPON_4, effect: constants.WEAPON_4_EFFECT)
    }
}

class Weapon5: Weapon {
    init() {
        super.init(weaponName: constants.WEAPON_5, effect: constants.WEAPON_5_EFFECT)
    }
}

class Weapon6: Weapon {
    init() {
        super.init(weaponName: constants.WEAPON_6, effect: constants.WEAPON_6_EFFECT)
    }
}

class HealerWeapon: Weapon {
    init() {
        super.init(weaponName: constants.HEALER_WEAPON, effect: constants.HEALER_EFFECT)
    }
}
    
    class MagicWeapon: Weapon {
    init() {
        super.init(weaponName: constants.MAGIC_WEAPON, effect: constants.MAGIC_EFFECT)
    }
}




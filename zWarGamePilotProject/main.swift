//
//  main.swift
//  zWarGamePilotProject
//
//  Created by Jean-Michel ZARAGOZA on 02/05/2020.
//  Copyright © 2020 Jean-Michel ZARAGOZA. All rights reserved.
//

import Foundation

// MARK: - Development assistance variables

// Automatic generation of objects (true or false)
var initAuto: Bool = true

//
//// Display of initiated objects (true or false)
//var displayColoredBalls: Bool = false


// MARK: - instantiation of the class "game", the heart of the game.

var zWarGame = Game(gameName: constants.GAME_TITLE)

// MARK: - Run the main function in the game instantiation

zWarGame.mainGame()


print("\n   FIN \n\n")





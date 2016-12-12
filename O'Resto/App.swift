//
//  App.swift
//  O'Resto
//
//  Created by Allan Contaret on 11/12/2016.
//  Copyright © 2016 Allan Contaret. All rights reserved.
//

import Foundation

struct Restaurant {
    var name: String
    var address : String
    var imageName : String
}

struct TIBRestaurants {
    static func getAllRestaurants()-> [Restaurant] {
        return [
            Restaurant(name :"Hippopotamus", address :"31 Rue Marie-Andrée Lagroua Weill-Hallé, 75013 Paris", imageName : "vignette_hippo"),
            Restaurant(name: "Buffalo Grill", address: "15 Place de la République, 75003 Paris", imageName: "buffalogrill" ),
            Restaurant(name: "Pataterie", address: "27 rue de la Basse Quinte Espace Pompadour, 94000 Créteil", imageName: "pataterie")
        ]
    }
}

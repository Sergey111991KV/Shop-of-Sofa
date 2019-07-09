//
//  Sofa.swift
//  Shop of  Sofa
//
//  Created by Сергей Косилов on 09/07/2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

struct Sofa {
    
    var name: String
    var category: Category
    var image: [String]
    
    
    
    static var all: [Sofa] { return[
        Sofa(name: "Ника", category:  .straightFabric, image: ["ника1", "ника1"]),
        Sofa(name: "Лоренцо", category: .cornerModular, image: ["лоренцо","лоренцо-2"]),
        Sofa(name: "Экзотик 4", category: .cornerModular, image: ["экзотик4"]),
        Sofa(name: "Экзотик 7", category:  .cornerModular, image: ["экзотик7-2"]),
        Sofa(name: "Элита", category: .straightFabric, image: ["элита1", "элита2"]),
        Sofa(name: "Берг", category: .cornerLeather, image: ["берг2", "берг1"]),
        Sofa(name: "Навила4", category:  .cornerModular, image: ["навила4-1", "навила4"])
     
        ]}
}

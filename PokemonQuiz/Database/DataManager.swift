//
//  DataManager.swift
//  PokemonQuiz
//
//  Created by Hoang Doan on 11/20/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import Foundation

let kDatabaseName = "pokemon"
let kDatabaseExtension = "db"

class DataManager: NSObject {
    static let shared = DataManager()
    
    func getDatabaseFolder() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentPath + "/" + kDatabaseName + "." + kDatabaseExtension
        
    }
    
    func copyDatabaseIfNeed() {
        
        // 1. Get bundle path
        let bundlePath = Bundle.main.path(forResource: kDatabaseName, ofType: kDatabaseExtension)
        // 2. Get document path
        let documentPath = self.getDatabaseFolder()
        
        print(documentPath)
        
        // 3. Check if file not exist
        if !FileManager.default.fileExists(atPath: documentPath)  {
            // 4. Copy from bundlePath to documentPath
            do {
                print(bundlePath)
                print(documentPath)
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: documentPath)
            } catch  {
                print(error)
            }
        }
        
    }
    
    func generatePokemon(){
        GameSceneViewController.pokemonCollection.removeAll()
        // 1. Open database
        let database = FMDatabase(path: self.getDatabaseFolder())
        database?.open()
        // 2.Create query
        let selectQuery = "SELECT * FROM pokemon WHERE gen IN ('1', '2') ORDER BY RANDOM() LIMIT 4"
        
        // 3.Excute query
        do {
            let result = try database?.executeQuery(selectQuery, values: nil)
            while (result?.next())! {
                let pokemon = Pokemon()
               
                pokemon.pokemonName = result?.string(forColumn: "name")
                pokemon.pokemonGene = result?.string(forColumn: "gen")
                pokemon.pokemonID = Int((result?.string(forColumn: "id"))!)
                pokemon.pokemonColor = result?.string(forColumn: "color")
                pokemon.pokemonImg = result?.string(forColumn: "img")
                pokemon.pokemonTag = result?.string(forColumn: "tag")
                
                GameSceneViewController.pokemonCollection.append(pokemon)

            }
            
        } catch  {
            print("Select Failed: ",error)
        }
        // 4.Close database
        database?.close()
    }
}


//
//  Service.swift
//  SportsMatchTeste
//
//  Created by Gabriel de Castro Chaves on 01/08/22.
//

import Foundation

class Service {
    
    // MARK: - Welcome
    struct Welcome: Codable {
        let status: Int
        let object: [Object]
        
        enum CodingKeys: String, CodingKey {
            case status = "Status"
            case object = "Object"
        }
    }
    
    // MARK: - Object
    struct Object: Codable {
        let player: Player
        
        enum CodingKeys: String, CodingKey {
            case player = "Player"
        }
    }
    
    // MARK: - Player
    struct Player: Codable {
        let img: String
        let name: String
        let percentual: Double
        let pos, country: String
        let barras: Barras
        
        enum CodingKeys: String, CodingKey {
            case img, name, percentual, pos, country
            case barras = "Barras"
        }
    }
    
    
    // MARK: - Barras
    struct Barras: Codable {
        let copasDoMundoVencidas, copasDoMundoDisputadas: CopasDoMundoDas
        
        enum CodingKeys: String, CodingKey {
            case copasDoMundoVencidas = "Copas_do_Mundo_Vencidas"
            case copasDoMundoDisputadas = "Copas_do_Mundo_Disputadas"
        }
    }
    
    // MARK: - CopasDoMundoDas
    struct CopasDoMundoDas: Codable {
        let max, pla, pos: Int
    }
    
    
    //MARK: - Funcs
    func makeRequest(completion: @escaping (Welcome) -> ()) {
        guard let url = URL(string: "http://sportsmatch.com.br/teste/teste.json") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let player = try JSONDecoder().decode(Welcome.self, from: data)
                    completion(player)
                } catch let error {
                    print("error: \(error)")
                }
            }
        }
        task.resume()
    }
    
    
}



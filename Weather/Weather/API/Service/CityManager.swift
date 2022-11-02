//
//  CityManager.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import Foundation
class CityManager {
    
    static let shared = CityManager()
    private init () {}

    func getCity(completion: @escaping ([City]) -> ()) {
        
        guard let path = Bundle.main.path(forResource: "city", ofType: "json") else { return }
       
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([City].self, from: data)
            DispatchQueue.main.async {
                completion(object)
            }
        } catch {
            print("Can't parse cities \(error.localizedDescription)")
        }
    }
}

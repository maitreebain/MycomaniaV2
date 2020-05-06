//
//  DatabaseService.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 4/29/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DatabaseService {
    
    static let user = "user"
    static let shroomItems = "shrooms"
    
    private let db = Firestore.firestore()
    
    private init() { }
    
    static let shared = DatabaseService()
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let email = authDataResult.user.email else { return }
        
        db.collection(DatabaseService.user).document(authDataResult.user.uid).setData([
            "email" : email,
            "createdDate": Timestamp(date: Date())
        ]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
}

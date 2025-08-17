//
//  PersonViewModel.swift
//  PersonalCard
//
//  Created by Mehmet Emin Çetin on 17.08.2025.
//

import Foundation

class PersonViewModel: ObservableObject {
    @Published var person: Person
    
    init() {
        // Example Data
        self.person = Person(
            name: "Mehmet Emin Çetin",
            jobTitle: "iOS Developer",
            email: "contact@chetintech.com",
            phone: "+90 555 555 55 55",
            age: 22,
            salary: 120000.50,
            isEmployed: false
        )
    }
}

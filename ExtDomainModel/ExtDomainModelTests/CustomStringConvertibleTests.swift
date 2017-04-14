//
//  JobTests.swift
//  ExtDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class CustomStringConvertibleTests: XCTestCase {
  
    func testCurrency() {
        
        let tryUSD = Money(amount: 10, currency: "USD");
        XCTAssert(tryUSD.description == "USD10.0");
        
        let tryEUR = Money(amount: 20, currency: "EUR");
        XCTAssert(tryEUR.description == "EUR20.0");
        
        let tryGBP = Money(amount: 400, currency: "GBP");
        XCTAssert(tryGBP.description == "GBP400.0");
        
        let tryCAN = Money(amount: 9000, currency: "CAN");
        XCTAssert(tryCAN.description == "CAN9000.0");
        
    }
    
    func testJob() {
        
        let hourCheck = Job(title: "Designer", type: Job.JobType.Hourly(200.0));
        XCTAssert(hourCheck.description == "Designer makes $200.0 per Hour");
        
        let yearCheck = Job(title: "Programmer", type: Job.JobType.Salary(100000));
        XCTAssert(yearCheck.description == "Programmer makes $100000 per Year");
        
    }
    
    func testPerson() {
        
        let p = Person(firstName: "Saif", lastName: "Mustafa", age: 21);
        p.job = Job(title: "Designer", type: Job.JobType.Salary(100000));
        p.spouse = Person(firstName: "Scarlett", lastName: "Johansson", age: 21);
        
        XCTAssert(p.description == "Name: Saif Mustafa, Age: 21, Occupation: Designer makes $100000 per Year, Marrital Status: Married to Scarlett Johansson");
        
    }
    
    func testFamily() {
        
        let p1 = Person(firstName: "Saif", lastName: "Mustafa", age: 25);
        p1.job = Job(title: "Designer", type: Job.JobType.Salary(100000));
        
        let p2 = Person(firstName: "Coco", lastName: "Xu", age: 21);
        p2.job = Job(title: "Data Scientist", type: Job.JobType.Hourly(30.0));
        
        let all = Family(spouse1: p1, spouse2: p2);
        let kid = Person(firstName: "Caramel", lastName: "Freddy", age: 5);
        
        let _ = all.haveChild(kid);
        
        print(all.description);
        
        XCTAssert(all.description == "Here are all members of the family: Saif Mustafa, Coco Xu, Caramel Freddy, The total income for this family is: $160000");
        
    }
    
}

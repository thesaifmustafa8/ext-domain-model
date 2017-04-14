//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward & Saif Mustafa on 4/13/17.
//  Copyright © 2016 Saif Mustafa. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

protocol CustomStringConvertible {
    
    var description : String {
        
        get
        
    }
    
}

protocol Mathematics {
    
    func add(_ to: Money) -> Money;
    func subtract(_ to: Money) -> Money;
    
}

extension Double {
    
    var USD: Money {
        
        return Money(amount: Int(self), currency: "USD");
        
    }
    
    var EUR: Money {
        
        return Money(amount: Int(self), currency: "EUR");
        
    }
    
    var GBP: Money {
        
        return Money(amount: Int(self), currency: "GBP");
        
    }
    
    var CAN: Money {
        
        return Money(amount: Int(self), currency: "CAN");
        
    }
    
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
    
    public var amount : Int
    public var currency : String
    
    public var description: String {
        
        get {
            
            return "\(self.currency)\(Double(self.amount))";
            
        }
        
    }
    
    public func convert(_ to: String) -> Money {
        
        var convertedTo = amount;
        
        switch currency {
            
        case "USD":
            
            if(to == "GBP") {          // USD to GBP
                
                convertedTo = amount / 2;
                
            } else if (to == "EUR") {  // USD to EUR
                
                convertedTo = (amount * 3) / 2;
                
            } else if (to == "CAN") {  // USD to CAN
                
                convertedTo = (amount * 5) / 4;
                
            }
            
        case "GBP":
            
            if(to == "USD") {          // GBP to USD
                
                convertedTo = amount * 2;
                
            } else if (to == "EUR") {  // GBP to EUR
                
                convertedTo = (amount * 2) / 3;
                
            } else if (to == "CAN") {  // GBP to CAN
                
                convertedTo = (amount * 4) / 5;
                
            }
            
        case "EUR":
            
            if(to == "USD") {          // EUR to USD
                
                convertedTo = (amount * 2) / 3 ;
                
            } else if (to == "GBP") {  // EUR to GBP
                
                convertedTo = amount / 3;
                
            } else if (to == "CAN") {  // EUR to CAN
                
                convertedTo = (amount * 5) / 6;
                
            }
            
            
        case "CAN":
            
            if(to == "USD") {          // CAN to USD
                
                convertedTo = (amount * 4) / 5 ;
                
            } else if (to == "GBP") {  // CAN to GBP
                
                convertedTo = (amount * 6) / 5;
                
            } else if (to == "EUR") {  // CAN to EUR
                
                convertedTo = (amount * 5) / 6;
                
            }
            
        default: print("Sorry! Only these currencies are allowed: USD, GBP, EUR, CAN");
        
        break;
            
        }
        
        return Money(amount: convertedTo, currency: to);
        
    }
    
    public func add(_ to: Money) -> Money {
        
        let current = Money(amount: amount, currency: currency).convert(to.currency);
        
        let sum = current.amount + to.amount;
        
        return Money(amount: sum, currency: to.currency);
        
    }
    
    public func subtract(_ from: Money) -> Money {
        
        let current = Money(amount: amount, currency: currency).convert(from.currency);
        
        let sum = current.amount - from.amount;
        
        return Money(amount: sum, currency: from.currency);
        
    }
    
    
}


////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible {
    
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        
        case Hourly(Double)
        case Salary(Int)
        
    }
    
    public init(title : String, type : JobType) {
        
        self.title = title;
        self.type = type;
        
    }
    
    public var description: String {
        
        get {
            
            switch self.type {
                
            case .Hourly(let perHour) :
                
                return "\(title) makes $\(Double(perHour)) per Hour";
                
            case .Salary(let perYear) :
                
                return "\(title) makes $\(perYear) per Year";
                
            }
            
        }
        
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        
        switch self.type {
            
        case .Hourly(let val): return Int(val * Double(hours));
            
        case .Salary(let val): return val;
            
        }
        
    }
    
    open func raise(_ amt : Double) {
        
        switch self.type {
            
        case .Hourly(let val): self.type = JobType.Hourly(amt + val);
            
        case .Salary(let val): self.type = JobType.Salary(Int(amt) + val);
            
        }
        
    }
    
}

////////////////////////////////////
// Person
//
open class Person : CustomStringConvertible {
    
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    
    open var job : Job? {
        
        get { return self._job; }
        
        set(value) {
            
            if(self.age >= 16) {
                
                _job = value;
                
            } else {
                
                print("Sorry! You need to be atleast 16 to have a job!");
                
            }
            
        }
        
    }
    
    fileprivate var _spouse : Person? = nil
    
    open var spouse : Person? {
        
        get { return self._spouse; }
        
        set(value) {
            
            if(self.age >= 18) {
                
                _spouse = value;
                
            } else {
                
                print("Sorry! You cannot have a spouse if you're under 18!")
                
            }
            
        }
        
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
    }
    
    public var description : String {
        
        get {
            
            var str : String = "Name: \(self.firstName) \(self.lastName), Age: \(self.age), ";
            
            if(self._job == nil) {
                
                str = str + "Occupation: Unemployed, ";
                
            } else {
                
                str = str + "Occupation: " + (self._job?.description)! + ", ";
                
            }
            
            if(self._spouse == nil) {
                
                str = str + "Marrital Status: Single";
                
            } else {
                
                str = str + "Marrital Status: Married to " + (self._spouse?.firstName)! + " " + (self.spouse?.lastName)!;
                
            }
            
            return str;
            
        }
        
    }
    
    open func toString() -> String {
        
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(String (describing: self._job)) spouse:\(String (describing: self._spouse))]"
        
    }
    
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible {
    
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        
        if(spouse1._spouse == nil && spouse2._spouse == nil && spouse1.age >= 18 && spouse2.age >= 18) {
            
            members.append(spouse1);
            members.append(spouse2);
            
            spouse1.spouse = spouse2;
            spouse2.spouse = spouse1;
            
        } else {
            
            print("Sorry! Both need to be atleast 18 years of age and have no spouse!")
            
        }
        
    }
    
    public var description: String {
        
        get {
            
            var str : String = "Here are all members of the family: ";
            
            for member in members {
                
                str += (member.firstName + " " + member.lastName + ", ");
                
            }
            
            str += "The total income for this family is: $\(self.householdIncome())";
            
            return str;
            
        }
        
    }
    
    open func haveChild(_ child: Person) -> Bool {
        
        var hasOver21 = false;
        
        for oneMember: Person in members {
            
            if(oneMember.age > 21) {
                
                hasOver21 = true;
                
            }
            
        }
        
        if(hasOver21) {
            
            members.append(child);
            
        }
        
        return hasOver21;
        
    }
    
    open func householdIncome() -> Int {
        
        var total = 0;
        
        for member in members {
            
            if(member._job != nil && member.age >= 16 ) {
                
                total += (member._job?.calculateIncome(2000))!;
                
            }
            
        }
        
        return total;
        
    }
    
}

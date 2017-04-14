//
//  JobTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import ExtDomainModel

class ExtensionDoubleTests: XCTestCase {
  
    func testAll() {
        
        let USD = 10.0;
        let moneyUSD = USD.USD;
        
        let GBP = 20.0;
        let moneyGBP = GBP.GBP;
        
        let EUR = 400.0;
        let moneyEUR = EUR.EUR;
        
        let CAN = 9000.0;
        let moneyCAN = CAN.CAN;
        
        XCTAssert(moneyUSD.amount == 10);
        XCTAssert(moneyUSD.currency == "USD");
        
        XCTAssert(moneyGBP.amount == 20);
        XCTAssert(moneyGBP.currency == "GBP");
        
        XCTAssert(moneyEUR.amount == 400);
        XCTAssert(moneyEUR.currency == "EUR");
        
        XCTAssert(moneyCAN.amount == 9000);
        XCTAssert(moneyCAN.currency == "CAN");

        
    }
  
}

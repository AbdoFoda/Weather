//
//  weatherTests.swift
//  weatherTests
//
//  Created by Abdelrahman Sobhy on 21/07/2021.
//

import XCTest
@testable import weather



class weatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrentLocationExistance() throws {
        let mockSelect = LocationSelectionMockView()
        XCTAssert( mockSelect.suggestions.count > 0)
        XCTAssert( mockSelect.suggestions.first!.string == "Current Location")
    }
    
    func testTrie() throws {
        let trie = Trie()
        trie.insert(word: "Cairo", curNode: &trie.head)
        trie.insert( word: "Canada", curNode: &trie.head)
        let ans = trie.match(prefix: "Ca")
        XCTAssert(ans.count > 0)
        XCTAssert(ans[0] == "Cairo")
        XCTAssert(ans.count > 1)
        XCTAssert(ans[1] == "Canada")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

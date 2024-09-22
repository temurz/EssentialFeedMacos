//
//  LoadImageCommentsFromRemoteUseCaseTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 20/08/2024.
//

import Foundation
import XCTest
import EssentialFeedMacos
class ImageCommentsMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon2xxHTTPResponse() throws {
        try [199,150,300,400,500].forEach {
            value in
            let json = makeItemsJSON([])
            XCTAssertThrowsError (
                try ImageCommentsMapper.map(json, from: HTTPURLResponse(statusCode: value))
            )
        }
        
    }
    
    func test_map_throwsErrorOn2xxHTTPResponseWithInvalidJSON() throws {
        let invalidData = Data("invalid data".utf8)
        
        try [200, 201, 250, 280, 299].forEach { code in
            XCTAssertThrowsError (
                try ImageCommentsMapper.map(invalidData, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        
        try [200, 201, 250, 280, 299].forEach {  code in
            let result = try ImageCommentsMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: code))
            
            XCTAssertEqual(result, [])
        }
    }
    
    func test_map_deliversItemsOn2xxHTTPResponseWithJSONItems() throws {
        
        let item1 = makeItem(
            id: UUID(),
            message: "a message",
            createdAt: (Date(timeIntervalSince1970: 1598627222), "2020-08-28T15:07:02+00:00"),
            username: "a username"
        )
        
        let item2 = makeItem(id: UUID(),
                             message: "another message", 
                             createdAt: (Date(timeIntervalSince1970: 1577881882), "2020-01-01T12:31:22+00:00"),
                             username: "another username")
        
        let json = makeItemsJSON([item1.json, item2.json])
        
        try [200, 201, 250, 280, 299].enumerated().forEach { index, code in
            
            let result = try ImageCommentsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            
            XCTAssertEqual(result, [item1.model, item2.model])
        }
    }
    
    //MARK: - Helpers
    private func makeItem(id: UUID, message: String, createdAt: (date: Date, iso8601String: String), username: String) -> (model: ImageComment, json: [String: Any]) {
        let item = ImageComment(id: id, message: message, createdAt: createdAt.date, username: username)
        
        let jsonModel: [String: Any] = [
            "id": id.uuidString,
            "message": message,
            "created_at": createdAt.iso8601String,
            "author": [
                "username": username
            ]
        ]
        
        return (item, jsonModel)
    }
}

//
//  ListSnapshotTests.swift
//  EssentialFeediOSTests
//
//  Created by Temur on 25/09/2024.
//

import XCTest
import EssentialFeediOS
final class ListSnapshotTests: XCTestCase {

    func test_emptyList() {
        let sut = makeSUT()
        
        sut.display(emptyList())
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "EMPTY_LIST_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "EMPTY_LIST_dark")
    }
    
    func test_listWithAnErrorMessage() {
        let sut = makeSUT()
        
        sut.display(.error(message: "This is a multiline \nerror message"))
         
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "ERROR_MESSAGE_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "ERROR_MESSAGE_dark")
    }
    
    private func emptyList() -> [CellController] {
        return []
    }
    
    private func makeSUT() -> ListViewController {
        let controller = ListViewController()
        controller.loadViewIfNeeded()
        controller.tableView.separatorStyle = .none
        controller.tableView.showsVerticalScrollIndicator = false
        controller.tableView.showsHorizontalScrollIndicator = false
        return controller
    }
}

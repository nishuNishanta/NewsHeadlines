import XCTest
@testable import Headlines

final class StringExtensionTests: XCTestCase {

    func test_url_whenValidUrlExists_shouldReturnUrl() {
        let string = "https://www.monzo.com"
        XCTAssertNotNil(string.url)
    }

}

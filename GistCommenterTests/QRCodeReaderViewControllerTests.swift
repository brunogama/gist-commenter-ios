@testable import GistCommenter
import XCTest

internal class QRCodeReaderViewControllerTests: XCTestCase {

    var viewController: QRCodeReaderViewController?

    override func setUp() {
        super.setUp()
        viewController = QRCodeReaderRouter.createModule()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        _ = viewController?.view
        viewController?.viewWillAppear(false)
        viewController?.viewDidAppear(false)
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func test_checkTitleOnLaunch() {
        let sut = viewController?.title
        XCTAssertEqual(sut, "Detecting ...")
    }
}

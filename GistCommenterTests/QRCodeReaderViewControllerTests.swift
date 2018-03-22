@testable import GistCommenter
import XCTest

internal class QRCodeReaderViewControllerTests: XCTestCase {

    var viewController: QRCodeReaderViewController?

    override func setUp() {
        super.setUp()
        viewController = QRCodeReaderRouter.createModule(bundle: Bundle(for: QRCodeReaderRouter.self))
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

    func test_checkTitle_onUpdateStatusLabelAndTitle() {
        let text = "Check"
        viewController?.updateStatusLabelAndTitle(text)
        let sut = viewController?.title
        XCTAssertEqual(sut, text)
    }

    func test_checkStatusLabelText_onUpdateStatusLabelAndTitle() {
        let text = "Camera not available"
        viewController?.updateStatusLabelAndTitle(text)
        let sut = viewController?.statusLabel.text
        XCTAssertEqual(sut, text)
    }
}

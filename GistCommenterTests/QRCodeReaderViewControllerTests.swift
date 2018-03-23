import AVFoundation
@testable import GistCommenter
import UIKit
import XCTest

internal class QRCodeReaderViewControllerTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    private var viewController: QRCodeReaderViewController!
    private var controllerBootstrapper: ViewControllerBootstrapper<QRCodeReaderViewController>!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let mockCodeReader = MockQRCodeReader()
        viewController = QRCodeReaderRouter.createModule(bundle: bundle, codeReader: mockCodeReader)
        controllerBootstrapper = ViewControllerBootstrapper()
        controllerBootstrapper.setupTopLevelUI(withViewController: viewController)

    }

    override func tearDown() {
        viewController = nil
        controllerBootstrapper.tearDownTopLevelUI()
        controllerBootstrapper = nil
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

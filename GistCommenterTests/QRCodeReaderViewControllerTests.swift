
import AVFoundation
@testable import GistCommenter
import UIKit
import XCTest

internal class QRCodeReaderViewControllerTests: XCTestCase {

    var viewController: QRCodeReaderViewController?

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: QRCodeReaderRouter.self)
        let mockCodeReader = MockQRCodeReader()
        viewController = QRCodeReaderRouter.createModule(bundle: bundle, codeReader: mockCodeReader)
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

// MARK: - Utils

fileprivate final class MockQRCodeReader: NSObject, QRCodeReadable {
    var videoPreview: AVCaptureVideoPreviewLayer?
    var captureSession: AVCaptureSession = AVCaptureSession()
    var didRead: QRCodableListener?

    func startReading(completion: @escaping QRCodableListener) {}
    func stopReading() {}
}

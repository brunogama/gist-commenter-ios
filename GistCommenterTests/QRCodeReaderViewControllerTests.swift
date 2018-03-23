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

    func test_QRCodeReader_didReadCallback() {
        let expectation = self.expectation(description: "Waiting for QRCodeData")
        var stringValue: String?
        var area: CGRect?

        viewController?.codeReader?.startReading { string, scannedArea in
            stringValue = string
            area = scannedArea
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(stringValue, "https://foo.bar")
        XCTAssertEqual(area, CGRect(origin: CGPoint.zero, size: CGSize(width: 1, height: 1)))
    }
}

// MARK: - Utils

fileprivate final class MockQRCodeReader: NSObject, QRCodeReadable {
    var videoPreview: AVCaptureVideoPreviewLayer?
    var captureSession: AVCaptureSession = AVCaptureSession()
    fileprivate(set) var didRead: QRCodableListener?
    let callbackData: QRCodeData = ("https://foo.bar",
                                    CGRect(origin: CGPoint.zero, size: CGSize(width: 1, height: 1)))

    func startReading(completion: @escaping QRCodableListener) {
        didRead = completion
        didRead?(callbackData)
    }

    func stopReading() {}
}

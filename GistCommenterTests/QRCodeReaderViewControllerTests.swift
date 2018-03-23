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
        viewController = createModule()
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

    func test_title_onForceQRCoderCallback() {
        viewController?.presenter?.interactor?.startReader()

        let sut = viewController?.title

        XCTAssertEqual(sut, "https://foo.bar")
    }

    func test_viewFinderArea_onForceQRCoderCallback() {
        viewController?.presenter?.interactor?.startReader()

        let sut = viewController?.qrCodeViewFinder?.frame

        XCTAssertEqual(sut, CGRect(origin: CGPoint.zero, size: CGSize(width: 1, height: 1)))
    }

    func test_checkTitle_afterCancelDetectionAlerts() {
        viewController?.presenter?.interactor?.startReader()
        viewController?.loading()

        let sut = viewController?.title
        XCTAssertEqual(sut, "Detecting ...")
    }

    func test_viewFinderArea_afterCancelDetectionAlerts() {
        viewController?.presenter?.interactor?.startReader()
        viewController?.loading()

        let sut = viewController?.qrCodeViewFinder?.frame

        XCTAssertEqual(sut, CGRect.zero)
    }

    // MARK: - Private methods

    fileprivate func createModule() -> QRCodeReaderViewController {

        let view = QRCodeReaderViewController(nibName: "QRCodeReaderViewController",
                                              bundle: Bundle(for: type(of: self)))
        let interactor = MockQRCodeReaderInteractor()
        interactor.codeReader = MockQRCodeReader()
        let router = QRCodeReaderRouter()
        let presenter = QRCodeReaderPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}

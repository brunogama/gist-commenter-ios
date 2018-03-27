//
//  MockQRCodeReaderInteractor.swift
//  GistCommenterTests
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import AVFoundation
@testable import GistCommenter
import UIKit
import XCTest

internal class MockQRCodeReaderInteractor: NSObject, QRCodeReaderInteractorInputProtocol {
    var remoteDataManager: RemoteDataManagerInputProtocol?

    func retrieve(url: URL) {}

    weak var presenter: QRCodeReaderInteractorOutputProtocol?
    var codeReader: QRCodeReadable?

    // MARK: - QRCodeReaderInteractorInputProtocol

    func didReceived(data: QRCodeReadable.QRCodeData) {
        presenter?.didReceived(data: data)
    }

    func startReader() {
        guard let reader = codeReader as? MockQRCodeReader else {
            XCTFail("Couldnt cast to MockQRCodeReader")
            return
        }
        didReceived(data: reader.callbackData)
    }

    func stopReader() {
        codeReader?.stopReading()
    }
}

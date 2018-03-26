//
//  QRCodeReaderInteractor.swift
//  GistCommenter
//
//  Created Bruno Gama on 21/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

internal class QRCodeReaderInteractor: NSObject, QRCodeReaderInteractorInputProtocol {

    weak var presenter: QRCodeReaderInteractorOutputProtocol?
    var codeReader: QRCodeReadable?

    //        guard let substring = URLComponents(url: url, resolvingAgainstBaseURL: true)?
    //            .path
    //            .split(separator: "/")
    //            .last else {
    //                Logger.e("Failed to parse gist id")
    //                return
    //        }
    //
    //        let gistId = String(substring)


    // MARK: - QRCodeReaderInteractorInputProtocol

    func didReceived(data: QRCodeReadable.QRCodeData) {
        presenter?.didReceived(data: data)
    }

    func startReader() {
        codeReader?.startReading { stringValue, scannedCodeArea in
            self.didReceived(data: (stringValue, scannedCodeArea))
        }
    }

    func stopReader() {
        codeReader?.stopReading()
    }
}

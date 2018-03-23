//
//  MockQRCodeReader.swift
//  GistCommenterTests
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import AVFoundation
import UIKit

internal final class MockQRCodeReader: NSObject, QRCodeReadable {
    var videoPreview: AVCaptureVideoPreviewLayer?
    var captureSession: AVCaptureSession = AVCaptureSession()
    var hasCameraPermissions: Bool = true
    fileprivate(set) var didRead: QRCodableListener?
    let callbackData: QRCodeData = ("https://foo.bar",
                                    CGRect(origin: CGPoint.zero, size: CGSize(width: 1, height: 1)))

    func startReading(completion: @escaping QRCodableListener) {
        didRead = completion
        didRead?(callbackData)
    }

    func stopReading() {}
}

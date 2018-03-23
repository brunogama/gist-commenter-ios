//
//  QRCodeReadable.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import AVFoundation

internal protocol QRCodeReadable {
    typealias QRCodeData = (value: String, codeBounds: CGRect)
    typealias QRCodableListener = (QRCodeData) -> Void

    var videoPreview: AVCaptureVideoPreviewLayer? { get }
    var hasCameraPermissions: Bool { get }

    func startReading(completion: @escaping QRCodableListener)
    func stopReading()
}

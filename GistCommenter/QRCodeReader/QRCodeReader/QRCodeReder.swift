//
//  QRCodeReder.swift
//  GistCommenter
//
//  Created by Bruno Gama on 22/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import AVFoundation

internal final class QRCodeReder: NSObject, QRCodeReadable, AVCaptureMetadataOutputObjectsDelegate {

    fileprivate(set) var videoPreview: AVCaptureVideoPreviewLayer?
    fileprivate var captureSession: AVCaptureSession = AVCaptureSession()
    fileprivate var didRead: QRCodableListener?
    var hasCameraPermissions: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    override init() {
        super.init()

        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                          for: AVMediaType.video,
                                                          position: .back),
             let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
                fatalError("Failed to get the camera device")
        }

        captureSession.addInput(deviceInput)
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [.qr]

        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.videoPreview = videoPreviewLayer
    }

    // MARK: - QRCodeReadable
    func startReading(completion: @escaping QRCodableListener) {
        self.didRead = completion
        captureSession.startRunning()
    }

    func stopReading() {
        captureSession.stopRunning()
    }

    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        guard let redableObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            let code = redableObject.stringValue,
            let barCodeBounds = videoPreview?.transformedMetadataObject(for: redableObject)?.bounds
            else {
                return
        }

        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate)) //Vibrate the phone
        stopReading()

        didRead?((value: code, codeBounds: barCodeBounds))
    }
}

// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {
  /// Please enable Camera access for the App
  internal static let alertMessageCameraPermission = L10n.tr("Localizable", "alertMessageCameraPermission")
  /// Atention
  internal static let alertTitleCameraPermission = L10n.tr("Localizable", "alertTitleCameraPermission")
  /// Camera not available
  internal static let cameraNotAvailable = L10n.tr("Localizable", "cameraNotAvailable")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Detected QR Code
  internal static let detectedQRCode = L10n.tr("Localizable", "detectedQRCode")
  /// Detecting ...
  internal static let detecting = L10n.tr("Localizable", "detecting")
  /// Gist Commenter - L10 Test
  internal static let gistCommenter = L10n.tr("Localizable", "GistCommenter")
  /// Gist Detail
  internal static let gistDetail = L10n.tr("Localizable", "gistDetail")
  /// Invalid QR Code
  internal static let invalidQrCodeMessage = L10n.tr("Localizable", "invalidQrCodeMessage")
  /// Login required
  internal static let loginRequired = L10n.tr("Localizable", "loginRequired")
  /// Message
  internal static let message = L10n.tr("Localizable", "message")
  /// No comments 😢
  internal static let noComments = L10n.tr("Localizable", "noComments")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Open Gist
  internal static let openGist = L10n.tr("Localizable", "openGist")
  /// Requesting Token
  internal static let requestingToken = L10n.tr("Localizable", "requestingToken")
  /// Send
  internal static let send = L10n.tr("Localizable", "send")
  /// Sending message
  internal static let sendingMessage = L10n.tr("Localizable", "sendingMessage")
  /// Settings
  internal static let settings = L10n.tr("Localizable", "settings")
  /// Token request failed
  internal static let tokenRequestFailed = L10n.tr("Localizable", "tokenRequestFailed")
  /// It turns out that the scanned QR Code is a Gist Url. Do you want to check-it outt?
  internal static let validQrCodeMessage = L10n.tr("Localizable", "validQrCodeMessage")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

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
  /// Detecting ...
  internal static let detecting = L10n.tr("Localizable", "detecting")
  /// Gist Commenter - L10 Test
  internal static let gistCommenter = L10n.tr("Localizable", "GistCommenter")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Settings
  internal static let settings = L10n.tr("Localizable", "settings")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

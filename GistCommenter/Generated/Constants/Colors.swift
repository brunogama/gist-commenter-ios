// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#24292e"></span>
  /// Alpha: 100% <br/> (0x24292eff)
  internal static let _24292E = ColorName(rgbaValue: 0x24292eff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#595d61"></span>
  /// Alpha: 100% <br/> (0x595d61ff)
  internal static let _595D61 = ColorName(rgbaValue: 0x595d61ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#7babe4"></span>
  /// Alpha: 100% <br/> (0x7babe4ff)
  internal static let _7Babe4 = ColorName(rgbaValue: 0x7babe4ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5a7a9"></span>
  /// Alpha: 100% <br/> (0xa5a7a9ff)
  internal static let a5A7A9 = ColorName(rgbaValue: 0xa5a7a9ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let ffffff = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}

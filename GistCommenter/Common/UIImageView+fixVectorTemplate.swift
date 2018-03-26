import UIKit

// fixing Bug in XCode
// http://openradar.appspot.com/18448072
extension UIImageView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.tintColorDidChange()
    }
}

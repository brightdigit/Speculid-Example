import Foundation

extension CGFloat {
  var cleanValue: String {
    return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(describing: self)
  }
}

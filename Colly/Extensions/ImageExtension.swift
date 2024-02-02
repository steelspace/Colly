import Foundation
import SwiftUI

extension Image {
  init(resource name: String, ofType type: String) {
    guard let path = Bundle.main.path(forResource: name, ofType: type),
          let image = UIImage(contentsOfFile: path) else {
      self.init(name)
      return
    }
    self.init(uiImage: image)
  }
}

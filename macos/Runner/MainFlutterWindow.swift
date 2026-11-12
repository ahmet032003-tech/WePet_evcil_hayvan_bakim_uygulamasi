import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController

    // macOS masaüstünde dengeli mobil/tablet pencere boyutu ve merkezleme
    let defaultWidth: CGFloat = 430
    let defaultHeight: CGFloat = 850
    if let screen = NSScreen.main {
      let screenRect = screen.visibleFrame
      let x = screenRect.midX - (defaultWidth / 2)
      let y = screenRect.midY - (defaultHeight / 2)
      self.setFrame(NSRect(x: x, y: y, width: defaultWidth, height: defaultHeight), display: true)
    }
    self.minSize = NSSize(width: 375, height: 600)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}

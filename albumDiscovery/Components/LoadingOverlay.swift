import UIKit

class LoadingOverlay {
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    func showOverlay(frame: CGRect? = nil,
                     backgroundColor: UIColor? = .white) {
        var loaderFrame: CGRect!
        if let frame = frame {
            loaderFrame = frame
        } else {
            loaderFrame = UIApplication.shared.keyWindow!.frame
        }
        overlayView = UIView(frame: loaderFrame)
        overlayView.accessibilityViewIsModal = true
        overlayView.backgroundColor = backgroundColor

        activityIndicator = UIActivityIndicatorView(style: .gray)

        activityIndicator.center = CGPoint(x: loaderFrame.width / 2, y: loaderFrame.height / 2)
        overlayView.addSubview(activityIndicator)
        overlayView.tag = 1234

        activityIndicator.startAnimating()
        UIApplication.shared.keyWindow!.addSubview(overlayView)
    }

    func hideOverlayView() {
        activityIndicator.stopAnimating()
        UIApplication.shared.keyWindow!.subviews.forEach({ view in
            if view.tag == 1234 {
                view.removeFromSuperview()
            }
        })
    }
}


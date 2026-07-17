import AppKit
import QuartzCore

@objc(OakZoomingIcon) final class OakZoomingIcon: NSWindow {
	@objc(zoomIcon:fromRect:) @discardableResult class func zoom(icon: NSImage, from aRect: NSRect) -> OakZoomingIcon {
		return OakZoomingIcon(icon: icon, rect: aRect)
	}

	init(icon: NSImage, rect aRect: NSRect) {
		super.init(contentRect: aRect.insetBy(dx: -56, dy: -56), styleMask: .borderless, backing: .buffered, defer: false)

		isReleasedWhenClosed = false
		ignoresMouseEvents   = true
		backgroundColor      = .clear
		isOpaque             = false
		level                = .popUpMenu

		let view = contentView!
		view.wantsLayer = true

		let layer = CALayer()
		view.layer!.addSublayer(layer)

		let image = icon.copy() as! NSImage
		image.size = view.bounds.size

		layer.bounds   = NSRect(origin: .zero, size: aRect.size)
		layer.position = NSPoint(x: view.bounds.midX, y: view.bounds.midY)
		layer.contents = image

		orderFront(self)

		// Layer properties changed in this run loop cycle will not be animated
		DispatchQueue.main.async { self.runAnimation(layer) }
	}

	private func runAnimation(_ layer: CALayer) {
		let slow = NSApp.currentEvent?.modifierFlags.contains(.shift) == true
		let duration: CFTimeInterval = 0.25 * (slow ? 10 : 1)

		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)
		CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeIn))
		CATransaction.setCompletionBlock { self.close() }

		layer.bounds  = contentView!.bounds
		layer.opacity = 0

		CATransaction.commit()
	}
}

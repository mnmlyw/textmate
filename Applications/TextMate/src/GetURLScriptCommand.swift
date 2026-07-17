import AppKit

@objc(GetURLScriptCommand) final class GetURLScriptCommand: NSScriptCommand {
	override func performDefaultImplementation() -> Any? {
		guard var urlString = directParameter as? String else { return nil }
		if urlString.hasPrefix("txmt:") && !urlString.hasPrefix("txmt://") {
			urlString = "txmt://" + urlString.dropFirst(5)
		}
		if let url = URL(string: urlString) {
			NSApp.sendAction(Selector(("handleTxMtURL:")), to: nil, from: url)
		}
		return nil
	}
}

/**
 Utilities for strings
 - author: Wacko
 - date: 03/30/2019
 */
import Foundation

/**
 Static function to centralize the NSLocalizedString requests (and to avoid writing so much code that is not needed
 - author: Wacko
 - date: 03/30/2019
 */
public func LocalString(key: String, comment: String? = nil) -> String {
    let cmnt = comment ?? ""
    return NSLocalizedString(key, comment: cmnt)
}

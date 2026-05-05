# Mobiki Indoor Map SDK — iOS

Indoor navigation SDK for iOS. Drop in a single view controller and get a
fully working indoor map with Bluetooth positioning, pathfinding, and
turn-by-turn directions.

Distributed as a binary XCFramework via Swift Package Manager. The source
code lives in a private repository; this repository hosts only the public
API and the binary release.

---

## Requirements

| | Minimum |
|---|---|
| iOS | 15.0 |
| Xcode | 15+ |
| Swift | 5.9 |

---

## Installation — Swift Package Manager

In Xcode: **File → Add Package Dependencies**

```
https://github.com/Mobiki/mobiki-map-sdk
```

Pin to **Up to Next Major Version** from `1.0.0`.

Or add to `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Mobiki/mobiki-map-sdk", from: "1.0.0")
]
```

---

## Setup

Call `configure` once at app launch — before any map is shown:

```swift
// AppDelegate.swift
import MobikiSDK

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions ...) -> Bool {
    Mobiki.configure(apiKey: "YOUR_API_KEY")
    return true
}
```

> Your API key is provided by Mobiki. Contact **support@mobiki.uk** to get one.

---

## Usage

### Scenario 1 — Open map (browse only)

```swift
import MobikiSDK

let mapVC = MobikiMapViewController(venueId: "YOUR_VENUE_ID")
mapVC.delegate = self
navigationController?.pushViewController(mapVC, animated: true)
```

### Scenario 2 — Open map with a room pre-selected

```swift
let mapVC = MobikiMapViewController(
    venueId: "YOUR_VENUE_ID",
    selectedRoomId: "store_042"
)
mapVC.delegate = self
navigationController?.pushViewController(mapVC, animated: true)
```

The map opens, scrolls to the right floor, highlights the room, and draws
a route from the user's current position (or venue gate if there is no
Bluetooth fix yet).

### Scenario 3 — From-To navigation

```swift
let mapVC = MobikiMapViewController(venueId: "YOUR_VENUE_ID")
mapVC.delegate = self
navigationController?.pushViewController(mapVC, animated: true)

func mapDidLoad(venueId: String) {
    mapVC.navigate(from: "entrance_001", to: "store_042")
}
```

---

## Delegate

```swift
extension YourViewController: MobikiMapDelegate {
    func mapDidLoad(venueId: String) { }
    func mapDidSelectRoom(_ room: MobikiRoom) { }
    func mapDidPreselectRoom(_ room: MobikiRoom, routeSource: MobikiRouteSource) { }
    func mapDidFindRoute(_ route: MobikiRoute) { }
    func mapDidFail(error: Error) { }
}
```

All delegate methods are optional.

---

## Configuration

```swift
var config = MobikiConfig()
config.tintColor                = .systemBlue
config.language                 = "tr"
config.defaultRouteType         = .stepFree
config.kioskMode                = false
config.floorSelectorPosition    = .leading       // .leading | .trailing | .hidden
config.floorSelectorButtonSize  = 36
config.routeTypePickerEnabled   = true           // false → drive route type from your own UI
config.routeAnimationEnabled    = true

Mobiki.configure(apiKey: "YOUR_API_KEY", config: config)
```

### Route types

| Value | Description |
|---|---|
| `.fast` | Shortest path (default) |
| `.stairs` | Prefer stairs |
| `.elevator` | Prefer elevator |
| `.stepFree` | No stairs or escalators (wheelchair) |
| `.freight` | Freight elevators only |

### Driving the engine from custom UI

If you turn off the SDK's built-in chrome
(`floorSelectorPosition == .hidden`, `routeTypePickerEnabled == false`),
use the public APIs to drive everything from your own buttons:

```swift
mapVC.setRouteType(.elevator)
mapVC.selectRoom(roomId: "5012")
mapVC.navigateTo(roomId: "5012")
mapVC.navigate(from: "1010", to: "5012")
```

You can also embed the SDK-rendered controls in your own container
instead of disabling them:

```swift
mapVC.floorSelectorView?.translatesAutoresizingMaskIntoConstraints = false
myCustomContainer.addSubview(mapVC.floorSelectorView!)
NSLayoutConstraint.activate([...])
```

---

## Models

### `MobikiRoom`
```swift
room.id        // String
room.name      // String
room.floor     // Int
room.category  // String?
```

### `MobikiRoute`
```swift
route.source          // MobikiRouteSource
route.toRoom          // MobikiRoom
route.distanceMeters  // Double
route.steps           // [MobikiRouteStep]
```

### `MobikiRouteSource`
```swift
.currentLocation
.gate
.room(MobikiRoom)
```

### `MobikiRouteStep`
```swift
step.instruction      // String
step.distanceMeters   // Double
step.floor            // Int
```

---

## Example app

`Example/MobikiExample.xcodeproj` is a working host app that consumes
the SDK via the binary target in this repository. It walks through the
three common scenarios (just open, preselect room, from-to navigation)
with an on-screen log so you can watch the delegate callbacks fire.

```bash
open Example/MobikiExample.xcodeproj
```

Set your API key in `Example/MobikiExample/AppDelegate.swift`:

```swift
Mobiki.configure(apiKey: "YOUR_API_KEY")
```

The hardcoded venue ID points at the public Mobiki demo venue (Perpa).
Replace it with your own venue ID once you have your API key.

---

## Errors

| Error | Cause |
|---|---|
| `invalidApiKey` | API key not recognised or inactive |
| `licenseExpired` | License period ended |
| `venueNotFound` | Venue ID not registered for this key |
| `networkUnavailable` | No internet connection |

---

## Support

**Email:** support@mobiki.uk
**Web:** https://mobiki.uk

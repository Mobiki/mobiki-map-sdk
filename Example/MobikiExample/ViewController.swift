import UIKit
import MobikiSDK

class ViewController: UIViewController {

    // MARK: - UI

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Mobiki SDK"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textAlignment = .center
        return l
    }()

    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "v\(Mobiki.version) — Perpa Ticaret Merkezi"
        l.font = .systemFont(ofSize: 13)
        l.textColor = .secondaryLabel
        l.textAlignment = .center
        return l
    }()

    private let logView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = .monospacedSystemFont(ofSize: 11, weight: .regular)
        tv.backgroundColor = UIColor.systemGray6
        tv.layer.cornerRadius = 10
        tv.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        tv.text = "— Loglar burada görünecek —\n"
        return tv
    }()

    // 3 farklı senaryo için 3 buton
    private lazy var btn1 = makeButton(title: "Sadece Haritayı Aç",     subtitle: "Senaryo 1", action: #selector(scenario1))
    private lazy var btn2 = makeButton(title: "Oda Seçili Aç",          subtitle: "Senaryo 2 — store_042", action: #selector(scenario2))
    private lazy var btn3 = makeButton(title: "From-To Navigasyon",     subtitle: "Senaryo 3 — giriş → oda", action: #selector(scenario3))
    private lazy var clearBtn: UIButton = {
        var c = UIButton.Configuration.tinted()
        c.title = "Logları Temizle"
        c.cornerStyle = .medium
        return UIButton(configuration: c)
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MobikiSDK Demo"
        view.backgroundColor = .systemBackground
        setupLayout()
        clearBtn.addTarget(self, action: #selector(clearLogs), for: .touchUpInside)
        log("✅ SDK hazır — v\(Mobiki.version)")
    }

    // MARK: - Layout

    private func setupLayout() {
        let header = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        header.axis = .vertical; header.spacing = 4

        let buttons = UIStackView(arrangedSubviews: [btn1, btn2, btn3, clearBtn])
        buttons.axis = .vertical; buttons.spacing = 8

        let main = UIStackView(arrangedSubviews: [header, logView, buttons])
        main.axis = .vertical; main.spacing = 16
        main.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(main)
        NSLayoutConstraint.activate([
            main.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            main.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            main.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            main.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logView.heightAnchor.constraint(greaterThanOrEqualToConstant: 180),
            btn1.heightAnchor.constraint(equalToConstant: 50),
            btn2.heightAnchor.constraint(equalToConstant: 50),
            btn3.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    // MARK: - Scenarios

    /// Senaryo 1: Sadece haritayı aç — kullanıcı kendisi gezer
    @objc private func scenario1() {
        log("─── Senaryo 1: Haritayı aç ───")
        log("📡 Venue ID: 6910928c3cef486ec06134da")
        let mapVC = MobikiMapViewController(venueId: "6910928c3cef486ec06134da")
        mapVC.delegate = self
        mapVC.title = "Perpa"
        log("▶ MobikiMapViewController açılıyor...")
        navigationController?.pushViewController(mapVC, animated: true)
    }

    /// Senaryo 2: Oda ID vererek haritayı o oda seçili aç
    @objc private func scenario2() {
        log("─── Senaryo 2: Oda seçili aç ───")
        log("📡 Venue: 6910928c3cef486ec06134da")
        log("🏠 Hedef oda: store_042")
        log("⚙️ Konum biliniyorsa → mevcut konumdan rota")
        log("⚙️ Konum bilinmiyorsa → gate'den rota")
        let mapVC = MobikiMapViewController(
            venueId: "6910928c3cef486ec06134da",
            selectedRoomId: "store_042"           // ← müşteri bu kadar
        )
        mapVC.delegate = self
        mapVC.title = "Perpa — Mağazaya Git"
        log("▶ Harita açılıyor, oda yüklenince seçilecek...")
        navigationController?.pushViewController(mapVC, animated: true)
    }

    /// Senaryo 3: Başlangıç ve bitiş odası belirterek navigasyon başlat
    @objc private func scenario3() {
        log("─── Senaryo 3: From-To navigasyon ───")
        log("🚩 Başlangıç: entrance_001 (giriş kapısı)")
        log("🏁 Hedef   : store_042")
        let mapVC = MobikiMapViewController(venueId: "6910928c3cef486ec06134da")
        mapVC.delegate = self
        mapVC.title = "Perpa — Navigasyon"
        // Harita açıldıktan sonra from-to çizdir
        // (mapDidLoad callback'inde navigate çağrılır)
        pendingNavigation = ("entrance_001", "store_042")
        log("▶ Harita açılıyor...")
        navigationController?.pushViewController(mapVC, animated: true)
    }

    private var pendingNavigation: (from: String, to: String)?

    // MARK: - Helpers

    private func makeButton(title: String, subtitle: String, action: Selector) -> UIButton {
        var c = UIButton.Configuration.filled()
        c.title = title
        c.subtitle = subtitle
        c.cornerStyle = .large
        c.imagePadding = 6
        let b = UIButton(configuration: c)
        b.addTarget(self, action: action, for: .touchUpInside)
        return b
    }

    @objc private func clearLogs() {
        logView.text = "— Loglar temizlendi —\n"
    }

    private func log(_ message: String) {
        let time = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        DispatchQueue.main.async {
            self.logView.text += "[\(time)] \(message)\n"
            let bottom = NSRange(location: self.logView.text.count - 1, length: 1)
            self.logView.scrollRangeToVisible(bottom)
        }
    }
}

// MARK: - MobikiMapDelegate

extension ViewController: MobikiMapDelegate {

    func mapDidLoad(venueId: String) {
        log("✅ mapDidLoad: \(venueId)")

        // Senaryo 3: harita açıldı, şimdi from-to navigasyonu başlat
        if let nav = pendingNavigation,
           let topVC = navigationController?.topViewController as? MobikiMapViewController {
            log("🧭 From-To başlatılıyor: \(nav.from) → \(nav.to)")
            topVC.navigate(from: nav.from, to: nav.to)
            pendingNavigation = nil
        }
    }

    func mapDidPreselectRoom(_ room: MobikiRoom, routeSource: MobikiRouteSource) {
        switch routeSource {
        case .currentLocation:
            log("📍 Oda seçildi: \(room.name) — rota mevcut konumdan çiziliyor")
        case .gate:
            log("🚪 Oda seçildi: \(room.name) — konum yok, gate'den rota çiziliyor")
        case .room(let from):
            log("🏠 Oda seçildi: \(room.name) — \(from.name)'dan rota çiziliyor")
        }
    }

    func mapDidSelectRoom(_ room: MobikiRoom) {
        log("👆 Kullanıcı oda seçti: \(room.name) (kat \(room.floor))")
        guard let topVC = navigationController?.topViewController as? MobikiMapViewController else { return }
        topVC.navigateTo(roomId: room.id)
        log("🧭 Rota çiziliyor → \(room.name)")
    }

    func mapDidFindRoute(_ route: MobikiRoute) {
        let sourceLabel: String
        switch route.source {
        case .currentLocation: sourceLabel = "mevcut konum"
        case .gate:            sourceLabel = "giriş kapısı"
        case .room(let r):     sourceLabel = r.name
        }
        log("🗺️ Rota: \(sourceLabel) → \(route.toRoom.name)")
        log("   Mesafe: \(Int(route.distanceMeters))m · \(route.steps.count) adım")
    }

    func mapDidFail(error: Error) {
        log("❌ Hata: \(error.localizedDescription)")
    }
}

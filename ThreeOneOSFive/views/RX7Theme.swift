import SwiftUI

// MARK: - Colores RX7 MODZ
extension Color {
    static let rx7Background     = Color(hex: "000000")
    static let rx7Panel          = Color(hex: "0B0E14")
    static let rx7PanelAlt       = Color(hex: "121212")
    static let rx7Border         = Color(hex: "2A303C")

    static let rx7Cyan           = Color(hex: "00E5FF")
    static let rx7Purple         = Color(hex: "9C27B0")
    static let rx7Online         = Color(hex: "10B981")
    static let rx7SOS            = Color(hex: "E53935")

    static let rx7TextPrimary    = Color(hex: "FFFFFF")
    static let rx7TextSecondary  = Color(hex: "9CA3AF")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Glassmorphism RX7
struct RX7GlassPanel: ViewModifier {
    var cornerRadius: CGFloat = 18
    var isActive: Bool = false
    var accent: Color = .rx7Cyan

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.rx7Panel.opacity(0.75))
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        isActive ? accent.opacity(0.6) : Color.rx7Border,
                        lineWidth: 1
                    )
            )
            .shadow(
                color: isActive ? accent.opacity(0.25) : .clear,
                radius: 10
            )
    }
}

extension View {
    func rx7GlassPanel(
        cornerRadius: CGFloat = 18,
        isActive: Bool = false,
        accent: Color = .rx7Cyan
    ) -> some View {
        modifier(RX7GlassPanel(
            cornerRadius: cornerRadius,
            isActive: isActive,
            accent: accent
        ))
    }
}

// MARK: - Toggle deslizable RX7
struct RX7Toggle: View {
    let isOn: Bool
    let isProcessing: Bool
    let isBlocked: Bool
    let onToggle: (Bool) -> Void

    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            Capsule()
                .fill(
                    isBlocked
                        ? Color.orange.opacity(0.2)
                        : (isOn
                            ? Color.rx7Cyan.opacity(0.35)
                            : Color.rx7Border.opacity(0.7))
                )
                .frame(width: 52, height: 30)
                .overlay(
                    Capsule()
                        .stroke(
                            isOn ? Color.rx7Cyan : Color.clear,
                            lineWidth: 1.5
                        )
                )
                .shadow(
                    color: isOn ? Color.rx7Cyan.opacity(0.6) : .clear,
                    radius: 6
                )

            if isProcessing {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(0.7)
                    .frame(width: 26, height: 26)
                    .padding(2)
            } else {
                Circle()
                    .fill(isOn ? Color.white : Color.rx7TextSecondary)
                    .frame(width: 26, height: 26)
                    .padding(2)
                    .shadow(color: .black.opacity(0.4), radius: 3, y: 1)
            }
        }
        .onTapGesture {
            guard !isProcessing && !isBlocked else { return }
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                onToggle(!isOn)
            }
        }
        .disabled(isProcessing || isBlocked)
    }
}

// MARK: - Fila de toggle con icono + subtítulo + switch
struct RX7ToggleRow: View {
    let title: String
    let subtitle: String?
    let icon: String
    let isOn: Bool
    let isProcessing: Bool
    let isBlocked: Bool
    let onToggle: (Bool) -> Void

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        isBlocked
                            ? Color.orange.opacity(0.15)
                            : (isOn
                                ? Color.rx7Cyan.opacity(0.22)
                                : Color.rx7PanelAlt)
                    )
                    .frame(width: 38, height: 38)
                    .overlay(
                        Circle()
                            .stroke(
                                isOn ? Color.rx7Cyan.opacity(0.7) : Color.rx7Border,
                                lineWidth: 1
                            )
                    )

                Image(systemName: isBlocked ? "lock.fill" : icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(
                        isBlocked
                            ? .orange
                            : (isOn ? Color.rx7Cyan : .white)
                    )
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(
                        isBlocked
                            ? Color.rx7TextSecondary
                            : Color.rx7TextPrimary
                    )
                    .lineLimit(1)

                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(
                            isOn ? Color.rx7Cyan : Color.rx7TextSecondary
                        )
                        .tracking(0.5)
                        .lineLimit(1)
                }
            }

            Spacer()

            RX7Toggle(
                isOn: isOn,
                isProcessing: isProcessing,
                isBlocked: isBlocked,
                onToggle: onToggle
            )
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .rx7GlassPanel(
            cornerRadius: 16,
            isActive: isOn,
            accent: .rx7Cyan
        )
    }
}

// MARK: - Tile (tarjeta compacta sin switch)
struct RX7ActionTile: View {
    let title: String
    let icon: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(isActive ? Color.rx7Cyan : .white)

                Text(title)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(isActive ? Color.rx7Cyan : .white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .rx7GlassPanel(
                cornerRadius: 14,
                isActive: isActive,
                accent: .rx7Cyan
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Toast superior
struct RX7Toast: View {
    let title: String
    let subtitle: String?
    let icon: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.rx7Cyan)

            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 9, weight: .medium))
                        .foregroundStyle(Color.rx7TextSecondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            Capsule()
                .fill(Color.rx7Panel.opacity(0.95))
                .overlay(
                    Capsule()
                        .stroke(Color.rx7Cyan.opacity(0.4), lineWidth: 1)
                )
                .shadow(color: Color.rx7Cyan.opacity(0.3), radius: 12)
        )
    }
}

// MARK: - Widget de música flotante
struct RX7MusicWidget: View {
    @State private var isPlaying = true

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.rx7TextSecondary)

            Image(systemName: "backward.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.white)

            Button {
                isPlaying.toggle()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.rx7Cyan)
            }

            Image(systemName: "forward.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.white)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.rx7Purple, Color.rx7Cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 42, height: 42)
                .overlay(
                    Image(systemName: "music.note")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                )

            Text("Popurulin - Sobre P...")
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(.white)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 60)

            Text("popurulin")
                .font(.system(size: 8, weight: .medium))
                .foregroundStyle(Color.rx7TextSecondary)
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 10)
        .frame(width: 76)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.rx7Panel.opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.rx7Border, lineWidth: 1)
                )
        )
    }
}

// MARK: - Scale Button Style
struct RX7ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
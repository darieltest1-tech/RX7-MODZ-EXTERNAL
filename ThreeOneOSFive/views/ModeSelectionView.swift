import SwiftUI

struct ModeSelectionView: View {
    @ObservedObject var session: AppSession
    @EnvironmentObject private var supabase: SupabaseService
    @State private var appeared = false
    @State private var showAdvancedSettings = false

    // MARK: - Key Helpers

    private var keyDisplayName: String {
        supabase.currentKey?.keyValue ?? "SIN KEY"
    }

    private var daysRemainingText: String {
        guard let key = supabase.currentKey else { return "—" }
        if key.isBanned { return "Baneada" }
        guard let expiresAt = key.expiresAt,
              let date = parseSupabaseDate(expiresAt) else {
            return "Sin expiración"
        }
        let now = Date()
        let diff = date.timeIntervalSince(now)
        if diff <= 0 { return "Expirada" }
        let totalMinutes = Int(diff / 60)
        let totalHours = totalMinutes / 60
        let days = totalHours / 24
        let minutes = totalMinutes % 60
        if days > 1 { return "\(days) días" }
        if days == 1 { return "1 día" }
        if totalHours >= 1 { return "\(totalHours)h \(minutes)m" }
        return "\(minutes)m"
    }

    private func parseSupabaseDate(_ string: String) -> Date? {
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = iso.date(from: string) { return date }
        iso.formatOptions = [.withInternetDateTime]
        if let date = iso.date(from: string) { return date }
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        if let date = df.date(from: string) { return date }
        df.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        if let date = df.date(from: string) { return date }
        let fixed = string.replacingOccurrences(of: " ", with: "T")
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = iso.date(from: fixed) { return date }
        return nil
    }

    private var keyStatusColor: Color {
        guard let key = supabase.currentKey else { return .white.opacity(0.5) }
        if key.isBanned { return Color(red: 0.9, green: 0.3, blue: 0.3) }
        if let expiresAt = key.expiresAt,
           let date = parseSupabaseDate(expiresAt) {
            let days = Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? 0
            if days < 0 { return Color(red: 0.9, green: 0.3, blue: 0.3) }
            if days <= 3 { return Color(red: 1.0, green: 0.6, blue: 0.2) }
        }
        return .white
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            rx7Background

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 30)

                    rx7LogoHeader

                    Spacer().frame(height: 22)

                    rx7TitleSection

                    Spacer().frame(height: 32)

                    VStack(spacing: 16) {
                        rx7ModeCard(
                            mode: .normal,
                            title: "FREE FIRE TH",
                            version: "VERSIÓN TH",
                            gameImageName: "FFNormalLogo",
                            accent: .rx7Cyan,
                            delay: 0.1
                        )
                        rx7ModeCard(
                            mode: .max,
                            title: "FREE FIRE MAX",
                            version: "VERSIÓN MAX",
                            gameImageName: "FFMaxLogo",
                            accent: .rx7Purple,
                            delay: 0.2
                        )
                    }
                    .padding(.horizontal, 20)

                    Spacer().frame(height: 22)

                    rx7ProfileCard
                        .padding(.horizontal, 20)

                    Spacer().frame(height: 22)

                    rx7AdvancedSettingsButton

                    Spacer().frame(height: 40)

                    rx7FooterSection

                    Spacer().frame(height: 30)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                appeared = true
            }
        }
    }

    // MARK: - Background

    private var rx7Background: some View {
        ZStack {
            Color.rx7Background.ignoresSafeArea()

            if UIImage(named: "rx7_dragones") != nil {
                Image("rx7_dragones")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.15)
                    .ignoresSafeArea()
            }

            RadialGradient(
                colors: [Color.rx7Cyan.opacity(0.15), Color.clear],
                center: .init(x: 0.5, y: 0.05),
                startRadius: 0,
                endRadius: 350
            )
            .ignoresSafeArea()
        }
    }

    // MARK: - Logo Header

    private var rx7LogoHeader: some View {
        ZStack {
            Circle()
                .fill(RadialGradient(
                    colors: [Color.rx7Cyan.opacity(0.25), Color.clear],
                    center: .center, startRadius: 20, endRadius: 70
                ))
                .frame(width: 140, height: 140)

            Circle()
                .stroke(Color.rx7Cyan.opacity(0.3), lineWidth: 1)
                .frame(width: 110, height: 110)

            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.rx7Cyan, .rx7Purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2.5
                )
                .frame(width: 90, height: 90)
                .shadow(color: .rx7Cyan.opacity(0.6), radius: 15)

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 68, height: 68)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.rx7Cyan.opacity(0.4), lineWidth: 1))
        }
    }

    // MARK: - Title

    private var rx7TitleSection: some View {
        VStack(spacing: 6) {
            Text("RX7 STORE")
                .font(.system(size: 26, weight: .heavy, design: .rounded))
                .tracking(2)
                .foregroundStyle(LinearGradient(
                    colors: [.rx7Cyan, .rx7Purple],
                    startPoint: .leading,
                    endPoint: .trailing
                ))

            Text("Elige un perfil para ver sus opciones de control")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.rx7TextSecondary)
        }
    }

    // MARK: - Mode Card

    @ViewBuilder
    private func rx7ModeCard(
        mode: FFMode,
        title: String,
        version: String,
        gameImageName: String,
        accent: Color,
        delay: Double
    ) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                session.selectedMode = mode
            }
        } label: {
            HStack(spacing: 14) {
                rx7GameIcon(name: gameImageName, mode: mode, accent: accent)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .tracking(0.5)

                    Text(version)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(accent)
                        .tracking(1)
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(accent.opacity(0.15))
                        .frame(width: 36, height: 36)
                        .overlay(
                            Circle()
                                .stroke(accent.opacity(0.5), lineWidth: 1)
                        )
                    Image(systemName: "chevron.up")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(accent)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .rx7GlassPanel(cornerRadius: 18, isActive: true, accent: accent)
        }
        .buttonStyle(RX7ScaleButtonStyle())
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 15)
        .animation(.easeOut(duration: 0.4).delay(delay), value: appeared)
    }

    @ViewBuilder
    private func rx7GameIcon(name: String, mode: FFMode, accent: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(
                    colors: [accent.opacity(0.3), accent.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 56, height: 56)

            if UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            } else {
                Image(systemName: mode == .normal ? "flame.fill" : "bolt.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(accent)
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(accent.opacity(0.4), lineWidth: 1))
        .shadow(color: accent.opacity(0.3), radius: 8)
    }

    // MARK: - Profile Card

    private var rx7ProfileCard: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [Color.rx7Cyan.opacity(0.4), Color.rx7Purple.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 44, height: 44)

                Image(systemName: "person.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(keyDisplayName)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text(supabase.currentKey?.label ?? "Usuario")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.rx7TextSecondary)
                    .lineLimit(1)
            }

            Spacer()

            Text(daysRemainingText)
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(keyStatusColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(keyStatusColor.opacity(0.12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(keyStatusColor.opacity(0.3), lineWidth: 1)
                        )
                )
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .rx7GlassPanel(cornerRadius: 16)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 15)
        .animation(.easeOut(duration: 0.4).delay(0.3), value: appeared)
    }

    // MARK: - Advanced Settings Button

    private var rx7AdvancedSettingsButton: some View {
        Button {
            showAdvancedSettings = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 12, weight: .semibold))
                Text("Ajustes avanzados")
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundStyle(Color.rx7TextSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.4).delay(0.4), value: appeared)
        .sheet(isPresented: $showAdvancedSettings) {
            SettingsView()
        }
    }

    // MARK: - Footer

    private var rx7FooterSection: some View {
        Text("CRACKED BY: DARIELMODZ")
            .font(.system(size: 11, weight: .medium))
            .foregroundStyle(Color.rx7TextSecondary)
            .opacity(appeared ? 1 : 0)
            .animation(.easeOut(duration: 0.4).delay(0.5), value: appeared)
    }
}

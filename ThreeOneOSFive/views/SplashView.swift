import SwiftUI

struct SplashView: View {
    let onFinished: () -> Void
    let externalProgress: Double
    let externalStep: String

    @State private var rotationAngle: Double = 0
    @State private var displayProgress: CGFloat = 0
    @State private var appeared = false
    @State private var glowPulse = false
    @State private var displayStep: String = "INICIANDO SISTEMA..."

    private let appName = "RX7 MODZ"

    init(
        externalProgress: Double = 0,
        externalStep: String = "INICIANDO SISTEMA...",
        onFinished: @escaping () -> Void
    ) {
        self.externalProgress = externalProgress
        self.externalStep = externalStep
        self.onFinished = onFinished
    }

    var body: some View {
        ZStack {
            background

            VStack(spacing: 0) {
                Spacer()

                logoSection

                Spacer().frame(height: 60)

                Text(appName)
                    .font(.system(size: 32, weight: .heavy, design: .rounded))
                    .tracking(4)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.rx7Cyan, .rx7Purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .rx7Cyan.opacity(0.5), radius: 12)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.2), value: appeared)

                Spacer().frame(height: 20)

                Text(displayStep)
                    .font(.system(size: 11, weight: .bold))
                    .tracking(3)
                    .foregroundStyle(Color.rx7Cyan.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .frame(height: 20)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: displayStep)
                    .opacity(appeared ? 1 : 0)

                Spacer().frame(height: 14)

                progressBar
                    .padding(.horizontal, 80)
                    .opacity(appeared ? 1 : 0)

                Spacer().frame(height: 8)

                Text("\(Int(displayProgress * 100))%")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .tracking(2)
                    .foregroundStyle(Color.rx7TextSecondary)
                    .opacity(appeared ? 1 : 0)

                Spacer()
                Spacer()
            }
        }
        .onAppear {
            startAnimations()
        }
        .onChange(of: externalProgress) { newValue in
            withAnimation(.easeInOut(duration: 0.4)) {
                displayProgress = CGFloat(min(max(newValue, 0), 1))
            }
        }
        .onChange(of: externalStep) { newValue in
            withAnimation(.easeInOut(duration: 0.3)) {
                displayStep = newValue
            }
        }
    }

    // MARK: - Background

    private var background: some View {
        ZStack {
            Color.rx7Background.ignoresSafeArea()

            RadialGradient(
                colors: [
                    Color.rx7Cyan.opacity(glowPulse ? 0.18 : 0.06),
                    Color.clear
                ],
                center: .init(x: 0.5, y: 0.45),
                startRadius: 0,
                endRadius: 350
            )
            .ignoresSafeArea()
        }
    }

    // MARK: - Logo Section

    private var logoSection: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.rx7Cyan.opacity(glowPulse ? 0.25 : 0.08),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 30,
                        endRadius: 120
                    )
                )
                .frame(width: 260, height: 260)

            ForEach(0..<28, id: \.self) { i in
                let angle = (Double(i) / 28.0) * 360.0
                let isHighlighted = i % 7 == 0

                Circle()
                    .fill(
                        isHighlighted
                            ? Color.rx7Cyan
                            : Color.rx7Cyan.opacity(0.35)
                    )
                    .frame(
                        width: isHighlighted ? 4 : 2.5,
                        height: isHighlighted ? 4 : 2.5
                    )
                    .shadow(
                        color: isHighlighted ? Color.rx7Cyan.opacity(0.9) : .clear,
                        radius: isHighlighted ? 5 : 0
                    )
                    .offset(y: -95)
                    .rotationEffect(.degrees(angle + rotationAngle))
            }

            Circle()
                .stroke(Color.rx7Cyan.opacity(0.15), lineWidth: 0.5)
                .frame(width: 190, height: 190)
                .rotationEffect(.degrees(rotationAngle * 0.5))

            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.rx7Cyan, .rx7Purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .frame(width: 120, height: 120)
                .shadow(color: .rx7Cyan.opacity(0.6), radius: 15)

            Circle()
                .stroke(Color.rx7Cyan.opacity(0.2), lineWidth: 0.5)
                .frame(width: 140, height: 140)

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.rx7Cyan.opacity(0.3), lineWidth: 0.5))
                .shadow(color: .rx7Cyan.opacity(0.5), radius: 12)
        }
        .frame(height: 260)
        .opacity(appeared ? 1 : 0)
        .scaleEffect(appeared ? 1 : 0.9)
        .animation(.easeOut(duration: 0.6), value: appeared)
    }

    // MARK: - Progress Bar

    private var progressBar: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.rx7Border)
                .frame(height: 4)

            Capsule()
                .fill(
                    LinearGradient(
                        colors: [.rx7Cyan, .rx7Purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: displayProgress * 220, height: 4)
                .shadow(color: .rx7Cyan.opacity(0.8), radius: 6)
        }
        .frame(width: 220)
    }

    // MARK: - Animaciones

    private func startAnimations() {
        withAnimation(.easeOut(duration: 0.4)) {
            appeared = true
        }
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            glowPulse = true
        }
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }
}

import SwiftUI
import UIKit

struct LoginView: View {
    @ObservedObject var session: AppSession
    @EnvironmentObject private var supabase: SupabaseService
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = "Clave incorrecta"
    @State private var shakeOffset: CGFloat = 0
    @State private var glowAnimation = false
    @State private var appeared = false
    @State private var isVerifying = false

    var body: some View {
        ZStack {
            background

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 20)

                    heroCard

                    Spacer().frame(height: 24)

                    titleSection

                    Spacer().frame(height: 26)

                    passwordField

                    Spacer().frame(height: 16)

                    loginButton

                    if showError {
                        errorMessageView
                    }

                    Spacer().frame(height: 22)

                    statusIndicators

                    Spacer().frame(height: 24)

                    footerSection

                    Spacer().frame(height: 30)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                glowAnimation = true
            }
            withAnimation(.easeOut(duration: 0.6)) {
                appeared = true
            }
        }
    }

    // MARK: - Background

    private var background: some View {
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
                colors: [
                    Color.rx7Cyan.opacity(glowAnimation ? 0.15 : 0.05),
                    Color.clear
                ],
                center: .init(x: 0.5, y: 0.15),
                startRadius: 0,
                endRadius: 400
            )
            .ignoresSafeArea()

            GeometryReader { geo in
                ForEach(0..<20, id: \.self) { _ in
                    Circle()
                        .fill(Color.rx7Cyan.opacity(0.4))
                        .frame(width: 2, height: 2)
                        .position(
                            x: CGFloat.random(in: 0...geo.size.width),
                            y: CGFloat.random(in: 0...geo.size.height)
                        )
                        .opacity(glowAnimation ? 0.7 : 0.15)
                }
            }
            .ignoresSafeArea()
        }
    }

    // MARK: - Hero Card (imagen arriba)

    private var heroCard: some View {
        ZStack(alignment: .topLeading) {
            // Imagen de fondo
            if UIImage(named: "login_hero") != nil {
                Image("login_hero")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } else {
                LinearGradient(
                    colors: [.rx7Panel, .rx7Background],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 200)
                .overlay(
                    Text("RX7 MODZ")
                        .font(.system(size: 32, weight: .heavy, design: .rounded))
                        .tracking(4)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.rx7Cyan, .rx7Purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
            }

            // Overlay oscuro arriba para que el badge se lea
            LinearGradient(
                colors: [
                    Color.black.opacity(0.5),
                    Color.clear,
                    Color.black.opacity(0.25)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 200)

            // Badge "RX7 / ACCESO DE LICENCIA"
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.rx7Online)
                    .frame(width: 6, height: 6)
                    .shadow(color: Color.rx7Online.opacity(0.9), radius: 4)

                Text("RX7")
                    .font(.system(size: 10, weight: .heavy))
                    .tracking(2)
                    .foregroundStyle(Color.rx7Cyan)

                Text("/")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(Color.rx7TextSecondary)

                Text("ACCESO DE LICENCIA")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1.5)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.55))
                    .overlay(
                        Capsule()
                            .stroke(Color.rx7Cyan.opacity(0.4), lineWidth: 1)
                    )
            )
            .padding(.top, 12)
            .padding(.leading, 12)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    LinearGradient(
                        colors: [.rx7Cyan.opacity(0.5), .rx7Purple.opacity(0.4)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
        )
        .shadow(color: .rx7Cyan.opacity(0.3), radius: 15)
        .padding(.horizontal, 20)
        .opacity(appeared ? 1 : 0)
        .scaleEffect(appeared ? 1 : 0.95)
        .animation(.easeOut(duration: 0.6).delay(0.15), value: appeared)
    }

    // MARK: - Title Section

    private var titleSection: some View {
        VStack(spacing: 6) {
            Text("INICIA SESIÓN")
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .tracking(2)
                .foregroundStyle(.white)
                .shadow(color: .rx7Cyan.opacity(0.4), radius: 8)

            Text("Pega tu licencia para abrir el panel RX7")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.rx7TextSecondary)
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.6).delay(0.25), value: appeared)
    }

    // MARK: - Password Field

    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "key.fill")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(Color.rx7Cyan)
                Text("KEY DE ACCESO")
                    .font(.system(size: 10, weight: .heavy))
                    .tracking(1.5)
                    .foregroundStyle(Color.rx7Cyan)
                Spacer()
                Text("LICENCIA")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(Color.rx7TextSecondary)
            }
            .padding(.horizontal, 4)

            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.rx7PanelAlt)
                        .frame(width: 34, height: 34)
                    Image(systemName: "key.horizontal.fill")
                        .foregroundStyle(Color.rx7Cyan)
                        .font(.system(size: 14, weight: .semibold))
                }

                SecureField("Pega tu key aquí", text: $password)
                    .textFieldStyle(.plain)
                    .foregroundStyle(.white)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.go)
                    .onSubmit(attemptLogin)
                    .disabled(isVerifying)

                if !password.isEmpty && !isVerifying {
                    Button {
                        password = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.rx7TextSecondary)
                            .font(.system(size: 14))
                    }
                } else {
                    Button {
                        if let clipboard = UIPasteboard.general.string {
                            password = clipboard
                        }
                    } label: {
                        Text("PEGAR")
                            .font(.system(size: 11, weight: .heavy))
                            .tracking(1)
                            .foregroundStyle(Color.rx7Cyan)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.rx7Panel.opacity(0.85))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(
                                showError
                                    ? Color.red.opacity(0.6)
                                    : Color.rx7Cyan.opacity(0.35),
                                lineWidth: 1.2
                            )
                    )
                    .shadow(color: Color.rx7Cyan.opacity(0.15), radius: 10)
            )
        }
        .padding(.horizontal, 28)
        .offset(x: shakeOffset)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.6).delay(0.35), value: appeared)
    }

    // MARK: - Login Button

    private var loginButton: some View {
        VStack(spacing: 10) {
            Button(action: attemptLogin) {
                HStack(spacing: 10) {
                    if isVerifying {
                        ProgressView()
                            .tint(.black)
                            .scaleEffect(0.9)
                        Text("VERIFICANDO...")
                            .font(.system(size: 15, weight: .heavy))
                            .tracking(2)
                    } else {
                        Text("INGRESAR")
                            .font(.system(size: 15, weight: .heavy))
                            .tracking(2)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 15, weight: .bold))
                    }
                }
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [.rx7Cyan, .rx7Purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: .rx7Cyan.opacity(0.5), radius: 15, y: 5)
                )
            }
            .disabled(password.isEmpty || isVerifying)
            .opacity((password.isEmpty || isVerifying) ? 0.45 : 1.0)

            Button {
                if !password.isEmpty {
                    attemptLogin()
                }
            } label: {
                Text("REINTENTAR VERIFICACIÓN")
                    .font(.system(size: 11, weight: .heavy))
                    .tracking(1.5)
                    .foregroundStyle(Color.rx7Cyan.opacity(0.9))
            }
            .disabled(password.isEmpty || isVerifying)
            .opacity(password.isEmpty ? 0.35 : 1.0)
        }
        .padding(.horizontal, 28)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.6).delay(0.45), value: appeared)
    }

    // MARK: - Error Message

    private var errorMessageView: some View {
        HStack(spacing: 6) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 11))
            Text(errorMessage)
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundStyle(Color(red: 0.9, green: 0.3, blue: 0.3))
        .padding(.top, 12)
        .transition(.opacity.combined(with: .move(edge: .top)))
    }

    // MARK: - Status Indicators

    private var statusIndicators: some View {
        HStack(spacing: 20) {
            statusDot(color: supabase.isConnected ? Color.rx7Online : .gray, label: "Online")
            statusDot(color: Color.rx7Cyan, label: "v2.0")
            statusDot(color: Color.rx7Purple, label: "Beta")
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.6).delay(0.55), value: appeared)
    }

    private func statusDot(color: Color, label: String) -> some View {
        HStack(spacing: 5) {
            Circle()
                .fill(color)
                .frame(width: 6, height: 6)
                .shadow(color: color.opacity(0.8), radius: 3)
            Text(label)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color.rx7TextSecondary)
        }
    }

    // MARK: - Footer

    private var footerSection: some View {
        HStack(spacing: 6) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 10))
                .foregroundStyle(Color.rx7Cyan.opacity(0.7))
            Text("Tu licencia se valida con el servidor")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.rx7TextSecondary)
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.6).delay(0.65), value: appeared)
    }

    // MARK: - Login Logic (Supabase)

    private func attemptLogin() {
        guard !isVerifying else { return }
        guard !password.isEmpty else { return }

        isVerifying = true
        showError = false

        Task {
            do {
                let key = try await supabase.verifyKey(password)
                log("login: key verificada — \(key.label ?? "sin label")")

                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)

                await MainActor.run {
                    isVerifying = false
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.isAuthenticated = true
                    }
                }

            } catch let error as SupabaseError {
                await MainActor.run {
                    isVerifying = false
                    handleLoginError(error)
                }
            } catch {
                await MainActor.run {
                    isVerifying = false
                    errorMessage = "Error de conexión"
                    showError = true
                    shakePasswordField()
                }
            }
        }
    }

    // MARK: - Handle Login Error

    private func handleLoginError(_ error: SupabaseError) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)

        switch error {
        case .keyNotFound:
            errorMessage = "Clave no encontrada"
        case .keyBanned:
            errorMessage = "Esta clave fue baneada"
        case .keyExpired:
            errorMessage = "Esta clave expiró"
        case .keyInactive:
            errorMessage = "Esta clave está desactivada"
        case .deviceLimitReached:
            errorMessage = "Límite de dispositivos alcanzado"
        case .deviceBanned:
            errorMessage = "Este dispositivo fue baneado"
        case .networkError:
            errorMessage = "Error de conexión"
        case .invalidURL, .noData, .decodingFailed:
            errorMessage = "Error del servidor"
        }

        showError = true
        shakePasswordField()
    }

    // MARK: - Shake Animation

    private func shakePasswordField() {
        withAnimation(.default) { shakeOffset = -10 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            withAnimation(.default) { shakeOffset = 10 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            withAnimation(.default) { shakeOffset = -8 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            withAnimation(.default) { shakeOffset = 8 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
            withAnimation(.default) { shakeOffset = 0 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation { showError = false }
            password = ""
        }
    }
}

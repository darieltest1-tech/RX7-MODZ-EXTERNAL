import SwiftUI

// MARK: - Modelo de toggle

struct PatchToggle: Identifiable {
    let id: String
    let displayName: String
    let patchFilename: String
    let icon: String
    let category: PatchCategory

    var isDynamic: Bool = false
    var isBlocked: Bool = false
    var blockMessage: String? = nil
    var downloadURL: String? = nil
    var remoteID: String? = nil
    var isPlaceholder: Bool = false   // 🆕 Toggles del diseño que aún no tienen parche real

    var fullFilename: String { "\(patchFilename).3105" }
    var normalizedName: String { Self.normalize(patchFilename) }

    static func normalize(_ name: String) -> String {
        var result = name
        if result.lowercased().hasSuffix(".3105") {
            result = String(result.dropLast(5))
        }
        result = result.trimmingCharacters(in: CharacterSet(charactersIn: " -_"))
        result = result.replacingOccurrences(
            of: "\\s+",
            with: " ",
            options: .regularExpression
        )
        return result.uppercased()
    }
}

enum PatchCategory: String, CaseIterable, Identifiable {
    case aimbot = "AIMBOT"
    case hologramas = "HOLOGRAMAS"

    var id: String { rawValue }
}

// MARK: - Registro RX7 (hardcoded + placeholders del diseño)

enum RX7Registry {

    // Toggles principales de la primera fila (tipo "tarjetas con switch")
    static func mainToggles(for mode: FFMode) -> [PatchToggle] {
        switch mode {
        case .normal:
            return [
                PatchToggle(
                    id: "rx7-aimbot-antena",
                    displayName: "AIMBOT CON ANTENA",
                    patchFilename: "AIMBOT CON ANTENA TH",
                    icon: "antenna.radiowaves.left.and.right",
                    category: .aimbot,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "rx7-holo-arm",
                    displayName: "HOLO ARM",
                    patchFilename: "HOLO ARM TH",
                    icon: "hand.raised.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "rx7-walk-hack",
                    displayName: "WALK HACK",
                    patchFilename: "WALK HACK TH",
                    icon: "figure.walk",
                    category: .aimbot,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "rx7-textura",
                    displayName: "TEXTURA",
                    patchFilename: "TEXTURA TH",
                    icon: "paintbrush.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]
        case .max:
            return [
                PatchToggle(
                    id: "rx7-aimbot-antena-max",
                    displayName: "AIMBOT CON ANTENA",
                    patchFilename: "AIMBOT CON ANTENA MAX",
                    icon: "antenna.radiowaves.left.and.right",
                    category: .aimbot,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "rx7-holo-arm-max",
                    displayName: "HOLO ARM",
                    patchFilename: "HOLO ARM MAX",
                    icon: "hand.raised.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "rx7-walk-hack-max",
                    displayName: "WALK HACK",
                    patchFilename: "WALK HACK MAX",
                    icon: "figure.walk",
                    category: .aimbot,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "rx7-textura-max",
                    displayName: "TEXTURA",
                    patchFilename: "TEXTURA MAX",
                    icon: "paintbrush.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]
        }
    }

    // Toggles con switch real (los que sí existen en tu app)
    static func toggles(for mode: FFMode, category: PatchCategory) -> [PatchToggle] {
        switch (mode, category) {
        case (.normal, .aimbot):
            return [
                PatchToggle(
                    id: "aimbot-cabeza-sin-antena",
                    displayName: "AIMBOT CABEZA",
                    patchFilename: "AIMBOT CABEZA SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-pecho-sin-antena",
                    displayName: "AIMBOT PECHO",
                    patchFilename: "AIMBOT PECHO SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-cuello-sin-antena",
                    displayName: "AIMBOT CUELLO",
                    patchFilename: "CUELLO SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-drag-avatar",
                    displayName: "AIMDRAG",
                    patchFilename: "Avatar_Aimdrag",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-balas-magicas",
                    displayName: "BALAS MÁGICAS",
                    patchFilename: "AVATAR BALAS MAGICAS SIN ANTENA",
                    icon: "sparkles",
                    category: .aimbot
                ),
            ]
        case (.max, .aimbot):
            return [
                PatchToggle(
                    id: "aimbot-cabeza-sin-antena-max",
                    displayName: "AIMBOT CABEZA",
                    patchFilename: "CABEZA FF MAX SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-cuello-sin-antena-max",
                    displayName: "AIMBOT CUELLO",
                    patchFilename: "CUELLO SIN ANTENA FF MAX",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-drag-sin-antena-max",
                    displayName: "AIMDRAG",
                    patchFilename: "DRAG FF MAX SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "balas-magicas-max",
                    displayName: "BALAS MÁGICAS",
                    patchFilename: "BALA MAGICA FF MAX",
                    icon: "sparkles",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-pecho-max",
                    displayName: "AIMBOT PECHO",
                    patchFilename: "PECHO FF MAX SIN ANTENA",
                    icon: "scope",
                    category: .aimbot,
                    isPlaceholder: true
                ),
            ]
        case (.normal, .hologramas):
            return [
                PatchToggle(
                    id: "holo-cian-ffmax",
                    displayName: "CIAN X FFMAX",
                    patchFilename: "CIAN X FFMAX TH",
                    icon: "cube.transparent",
                    category: .hologramas,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "holo-rtx-ffmax",
                    displayName: "RTX FF MAX",
                    patchFilename: "RTX FF NORMAL",
                    icon: "cube.transparent",
                    category: .hologramas
                ),
                PatchToggle(
                    id: "holo-azul-verde",
                    displayName: "AZUL X VERDE FFMAX",
                    patchFilename: "AZUL X VERDE FFMAX TH",
                    icon: "cube.transparent",
                    category: .hologramas,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "holo-rosa-blanco",
                    displayName: "ROSA X BLANCO BORDES",
                    patchFilename: "ROSA X BLANCO BORDES TH",
                    icon: "cube.transparent",
                    category: .hologramas,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "holo-rosa-robotico",
                    displayName: "ROSA ROBÓTICO FF MAX",
                    patchFilename: "ROSA ROBOTICO FF MAX",
                    icon: "cube.transparent",
                    category: .hologramas,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "holo-dorado",
                    displayName: "DORADO FF MAX",
                    patchFilename: "DORADO FF MAX",
                    icon: "cube.transparent",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]
        case (.max, .hologramas):
            return [
                PatchToggle(
                    id: "holo-rtx-max",
                    displayName: "RTX FF MAX",
                    patchFilename: "RTX FF MAX",
                    icon: "cube.transparent",
                    category: .hologramas
                ),
                PatchToggle(
                    id: "holo-pj-max",
                    displayName: "PJ FF MAX",
                    patchFilename: "PJ FF MAX",
                    icon: "person.fill",
                    category: .hologramas
                ),
                PatchToggle(
                    id: "holo-cian-max",
                    displayName: "CIAN X FFMAX",
                    patchFilename: "CIAN X FFMAX MAX",
                    icon: "cube.transparent",
                    category: .hologramas,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "holo-dorado-max",
                    displayName: "DORADO FF MAX",
                    patchFilename: "DORADO FF MAX",
                    icon: "cube.transparent",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]
        }
    }
}

// MARK: - Panel principal

struct ControlPanelView: View {
    @ObservedObject var session: AppSession
    @EnvironmentObject private var patchStore: PatchProjectStore
    @EnvironmentObject private var supabase: SupabaseService
    @EnvironmentObject private var patchesStore: PatchesStore
    @EnvironmentObject private var announcementsStore: AnnouncementsStore

    @State private var selectedCategory: PatchCategory = .aimbot
    @State private var activeToggles: Set<String> = []
    @State private var processingToggles: Set<String> = []
    @State private var activeMainToggles: Set<String> = []
    @State private var toast: ToastMessage? = nil
    @State private var showSettings = false
    @State private var alert: PatchStoreAlert? = nil
    @State private var showLogoutConfirmation = false
    @State private var appeared = false

    private var mode: FFMode { session.selectedMode ?? .normal }

    private var mainToggles: [PatchToggle] {
        RX7Registry.mainToggles(for: mode)
    }

    private var categoryToggles: [PatchToggle] {
        let hardcoded = RX7Registry.toggles(for: mode, category: selectedCategory)
        let dynamic = buildDynamicToggles(for: mode, category: selectedCategory)
        return hardcoded + dynamic
    }

    private func buildDynamicToggles(for mode: FFMode, category: PatchCategory) -> [PatchToggle] {
        let modeString = (mode == .normal) ? "normal" : "max"
        let categoryString = (category == .aimbot) ? "aimbot" : "hologramas"

        return patchesStore.remotePatches.compactMap { remote in
            guard remote.mode == modeString || remote.mode == "both" else { return nil }
            guard remote.category.lowercased().contains(categoryString) else { return nil }

            return PatchToggle(
                id: remote.patchKey,
                displayName: remote.displayName,
                patchFilename: remote.patchFilename,
                icon: remote.icon,
                category: category,
                isDynamic: true,
                isBlocked: remote.isBlocked,
                blockMessage: remote.blockMessage,
                downloadURL: remote.downloadUrl,
                remoteID: remote.id
            )
        }
    }

    var body: some View {
        ZStack {
            rx7Background

            HStack(spacing: 0) {
                // Panel lateral izquierdo
                rx7LeftPanel
                    .frame(width: 180)

                // Panel central (scroll)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        rx7MainGrid
                        rx7CategoryGrid
                        Spacer().frame(height: 20)
                    }
                    .padding(.horizontal, 14)
                    .padding(.top, 12)
                }
            }

            // Widget de música flotante
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    RX7MusicWidget()
                        .padding(.trailing, 6)
                        .padding(.bottom, 30)
                }
            }

            // Toast superior
            if let toast {
                VStack {
                    RX7Toast(
                        title: toast.message,
                        subtitle: "Modo Juego: activado",
                        icon: "rocket.fill"
                    )
                    .padding(.top, 16)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showSettings) { SettingsView() }
        .alert(item: $alert) { alert in
            Alert(
                title: Text(alert.titleKey),
                message: Text(alert.messageKey),
                dismissButton: .default(Text("OK"))
            )
        }
        .confirmationDialog(
            "Cerrar sesión",
            isPresented: $showLogoutConfirmation,
            titleVisibility: .visible
        ) {
            Button("Cerrar sesión", role: .destructive) { performLogout() }
            Button("Cancelar", role: .cancel) {}
        } message: {
            Text("Si cierras sesión deberás ingresar tu key de nuevo.")
        }
        .onAppear {
            syncToggleStates()
            withAnimation(.easeOut(duration: 0.4)) { appeared = true }
            Task { await loadDynamicPatchesIfNeeded() }
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
                colors: [Color.rx7Cyan.opacity(0.06), Color.clear],
                center: .init(x: 0.5, y: 0.05),
                startRadius: 0,
                endRadius: 320
            )
            .ignoresSafeArea()
        }
    }

    // MARK: - Panel lateral izquierdo

    private var rx7LeftPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Título RX7 MODZ
            HStack(spacing: 8) {
                Image(systemName: "shield.lefthalf.filled")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.rx7Cyan)
                Text("RX7 MODZ")
                    .font(.system(size: 13, weight: .heavy, design: .rounded))
                    .tracking(1.5)
                    .foregroundStyle(LinearGradient(
                        colors: [.rx7Cyan, .rx7Purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
            }
            .padding(.top, 20)
            .padding(.horizontal, 10)

            // Tarjeta edición seleccionada
            VStack(alignment: .leading, spacing: 4) {
                Text("EDICIÓN SELECCIONADA")
                    .font(.system(size: 8, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(Color.rx7TextSecondary)

                Text(mode.displayName)
                    .font(.system(size: 13, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)

                Text("Configuración del panel")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(Color.rx7TextSecondary)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .rx7GlassPanel(cornerRadius: 14, isActive: true, accent: .rx7Cyan)
            .padding(.horizontal, 10)

            // Sistema en línea
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.rx7Online)
                    .frame(width: 6, height: 6)
                    .shadow(color: Color.rx7Online.opacity(0.8), radius: 4)
                Text("Sistema en línea")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.rx7TextSecondary)
            }
            .padding(.horizontal, 12)

            // Preview de productos
            VStack(alignment: .leading, spacing: 6) {
                Text("PREVIEW DE PRODUCTOS")
                    .font(.system(size: 8, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(Color.rx7TextSecondary)

                HStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.rx7Purple.opacity(0.2))
                            .frame(width: 28, height: 28)
                        Image(systemName: "shippingbox.fill")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.rx7Purple)
                    }
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Disponible pronto:")
                            .font(.system(size: 8, weight: .medium))
                            .foregroundStyle(Color.rx7TextSecondary)
                        Text("MAX")
                            .font(.system(size: 11, weight: .heavy, design: .rounded))
                            .foregroundStyle(Color.rx7Purple)
                    }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .rx7GlassPanel(cornerRadius: 14)
            .padding(.horizontal, 10)

            // Categorías
            VStack(alignment: .leading, spacing: 6) {
                Text("CATEGORÍAS")
                    .font(.system(size: 8, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(Color.rx7TextSecondary)

                Text("\(categoryToggles.count) OPCIONES")
                    .font(.system(size: 8, weight: .bold))
                    .tracking(0.5)
                    .foregroundStyle(Color.rx7Cyan.opacity(0.7))
            }
            .padding(.horizontal, 12)
            .padding(.top, 4)

            ForEach(PatchCategory.allCases) { category in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedCategory = category
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: category == .aimbot ? "scope" : "cube.transparent")
                            .font(.system(size: 12, weight: .semibold))
                        Text(category.rawValue)
                            .font(.system(size: 11, weight: .bold))
                            .tracking(0.5)
                        Spacer()
                    }
                    .foregroundStyle(
                        selectedCategory == category
                            ? Color.rx7Cyan
                            : Color.rx7TextSecondary
                    )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                selectedCategory == category
                                    ? Color.rx7Cyan.opacity(0.12)
                                    : Color.clear
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        selectedCategory == category
                                            ? Color.rx7Cyan.opacity(0.5)
                                            : Color.clear,
                                        lineWidth: 1
                                    )
                            )
                    )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 10)
            }

            // Botón volver
            Button {
                withAnimation {
                    session.selectedMode = nil
                    activeToggles.removeAll()
                    activeMainToggles.removeAll()
                }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 11, weight: .bold))
                    Text("VOLVER")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(1)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.rx7Panel.opacity(0.8))
                        .overlay(Capsule().stroke(Color.rx7Border, lineWidth: 1))
                )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 10)

            Spacer()

            // Botón logout
            Button {
                showLogoutConfirmation = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 10, weight: .bold))
                    Text("SALIR")
                        .font(.system(size: 9, weight: .bold))
                        .tracking(1)
                }
                .foregroundStyle(Color.rx7TextSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 10)
            .padding(.bottom, 16)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            Rectangle()
                .fill(Color.rx7Panel.opacity(0.5))
                .overlay(
                    Rectangle()
                        .frame(width: 1)
                        .foregroundStyle(Color.rx7Border),
                    alignment: .trailing
                )
        )
        .opacity(appeared ? 1 : 0)
    }

    // MARK: - Cuadrícula principal (tarjetas grandes con switch)

    private var rx7MainGrid: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                ForEach(mainToggles.prefix(2)) { toggle in
                    rx7MainToggleCard(toggle)
                }
            }
            HStack(spacing: 10) {
                ForEach(mainToggles.dropFirst(2).prefix(2)) { toggle in
                    rx7MainToggleCard(toggle)
                }
            }
        }
    }

    @ViewBuilder
    private func rx7MainToggleCard(_ toggle: PatchToggle) -> some View {
        let isOn = activeMainToggles.contains(toggle.id)
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                if isOn {
                    activeMainToggles.remove(toggle.id)
                    showToast("\(toggle.displayName) desactivado", icon: "xmark.circle.fill")
                } else {
                    activeMainToggles.insert(toggle.id)
                    showToast("\(toggle.displayName) activado", icon: "checkmark.circle.fill")
                }
            }
        } label: {
            VStack(spacing: 10) {
                Image(systemName: toggle.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isOn ? Color.rx7Cyan : .white)

                Text(toggle.displayName)
                    .font(.system(size: 10, weight: .heavy))
                    .tracking(0.5)
                    .foregroundStyle(isOn ? Color.rx7Cyan : .white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .rx7GlassPanel(cornerRadius: 16, isActive: isOn, accent: .rx7Cyan)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Cuadrícula de categoría (toggles con switch)

    private var rx7CategoryGrid: some View {
        VStack(spacing: 10) {
            ForEach(categoryToggles) { toggle in
                RX7ToggleRow(
                    title: toggle.displayName,
                    subtitle: subtitleFor(toggle),
                    icon: toggle.icon,
                    isOn: activeToggles.contains(toggle.id),
                    isProcessing: processingToggles.contains(toggle.id),
                    isBlocked: toggle.isBlocked,
                    onToggle: { newValue in
                        handleToggle(toggle, isOn: newValue)
                    }
                )
            }
        }
    }

    private func subtitleFor(_ toggle: PatchToggle) -> String {
        if toggle.isPlaceholder && !activeToggles.contains(toggle.id) {
            return "DISPONIBLE PRONTO"
        }
        return activeToggles.contains(toggle.id) ? "ACTIVO" : "TOCA PARA ACTIVAR"
    }

    // MARK: - Lógica de toggles

    private func handleToggle(_ toggle: PatchToggle, isOn: Bool) {
        guard !processingToggles.contains(toggle.id) else { return }

        // Placeholder: no hay parche real todavía
        if toggle.isPlaceholder {
            if isOn {
                activeToggles.insert(toggle.id)
                showToast("Disponible pronto: \(toggle.displayName)", icon: "clock.fill")
            } else {
                activeToggles.remove(toggle.id)
            }
            return
        }

        if toggle.isBlocked && isOn {
            alert = PatchStoreAlert(
                titleKey: "Opción en mantenimiento",
                messageKey: toggle.blockMessage ?? "Esta opción no está disponible en este momento."
            )
            return
        }

        if isOn {
            let conflicts = categoryToggles.filter {
                $0.id != toggle.id && activeToggles.contains($0.id) && !$0.isPlaceholder
            }
            for c in conflicts { deactivatePatchSilently(c) }
            activatePatch(toggle)
        } else {
            deactivatePatch(toggle)
        }
    }

    private func activatePatch(_ toggle: PatchToggle) {
        processingToggles.insert(toggle.id)
        Task.detached(priority: .userInitiated) {
            do {
                guard let item = await findLibraryItem(for: toggle) else {
                    await MainActor.run {
                        processingToggles.remove(toggle.id)
                        showToast("Parche no encontrado: \(toggle.fullFilename)", icon: "exclamationmark.triangle.fill")
                    }
                    return
                }
                let project: PatchProject
                if item.summary.schemaVersion >= 2 && item.canInspectContents {
                    project = try PatchProjectLibrary.synchronizeWorkspace(item: item)
                } else {
                    guard let p = item.project else { throw PatchPackageError.invalidProject }
                    project = p
                }
                _ = try DevicePatchService.apply(project: project)
                await MainActor.run {
                    processingToggles.remove(toggle.id)
                    activeToggles.insert(toggle.id)
                    patchStore.reload()
                    showToast("Parche activado con éxito", icon: "checkmark.circle.fill")
                }
            } catch {
                await MainActor.run {
                    processingToggles.remove(toggle.id)
                    showToast("Error al activar el parche", icon: "exclamationmark.triangle.fill")
                }
            }
        }
    }

    private func deactivatePatch(_ toggle: PatchToggle) {
        processingToggles.insert(toggle.id)
        Task.detached(priority: .userInitiated) {
            do {
                guard let item = await findLibraryItem(for: toggle) else {
                    await MainActor.run {
                        processingToggles.remove(toggle.id)
                        activeToggles.remove(toggle.id)
                        showToast("Parche desactivado", icon: "xmark.circle.fill")
                    }
                    return
                }
                guard let receipt = DevicePatchService.latestReceipt(projectID: item.id) else {
                    await MainActor.run {
                        processingToggles.remove(toggle.id)
                        activeToggles.remove(toggle.id)
                        showToast("Parche desactivado", icon: "xmark.circle.fill")
                    }
                    return
                }
                try DevicePatchService.restore(receipt: receipt)
                await MainActor.run {
                    processingToggles.remove(toggle.id)
                    activeToggles.remove(toggle.id)
                    patchStore.reload()
                    showToast("Parche desactivado", icon: "xmark.circle.fill")
                }
            } catch {
                await MainActor.run {
                    processingToggles.remove(toggle.id)
                    showToast("Error al desactivar", icon: "exclamationmark.triangle.fill")
                }
            }
        }
    }

    private func deactivatePatchSilently(_ toggle: PatchToggle) {
        Task.detached(priority: .userInitiated) {
            guard let item = await findLibraryItem(for: toggle) else { return }
            guard let receipt = DevicePatchService.latestReceipt(projectID: item.id) else { return }
            try? DevicePatchService.restore(receipt: receipt)
            await MainActor.run {
                activeToggles.remove(toggle.id)
                patchStore.reload()
            }
        }
    }

    private func findLibraryItem(for toggle: PatchToggle) async -> PatchLibraryItem? {
        let target = toggle.normalizedName
        return await MainActor.run {
            patchStore.items.first { item in
                PatchToggle.normalize(item.packageURL.lastPathComponent) == target
            }
        }
    }

    private func syncToggleStates() {
        var active: Set<String> = []
        for toggle in categoryToggles {
            let target = toggle.normalizedName
            if let item = patchStore.items.first(where: {
                PatchToggle.normalize($0.packageURL.lastPathComponent) == target
            }), DevicePatchService.latestReceipt(projectID: item.id) != nil {
                active.insert(toggle.id)
            }
        }
        activeToggles = active
    }

    private func loadDynamicPatchesIfNeeded() async {
        if !patchesStore.remotePatches.isEmpty { return }
        do {
            let patches = try await patchesStore.fetchPatches()
            log("panel: \(patches.count) parches dinámicos cargados")
            await patchesStore.downloadAllPatches(patches)
        } catch {
            log("panel: error cargando parches: \(error)")
        }
    }

    private func showToast(_ message: String, icon: String) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
            toast = ToastMessage(message: message, icon: icon, color: .rx7Cyan)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 0.3)) { toast = nil }
        }
    }

    private func performLogout() {
        supabase.disconnect()
        activeToggles.removeAll()
        activeMainToggles.removeAll()
        processingToggles.removeAll()
        withAnimation(.easeInOut(duration: 0.3)) {
            session.selectedMode = nil
            session.isAuthenticated = false
        }
    }
}

// MARK: - Toast Message

struct ToastMessage: Equatable {
    let message: String
    let icon: String
    let color: Color

    static func == (lhs: ToastMessage, rhs: ToastMessage) -> Bool {
        lhs.message == rhs.message
    }
}
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
    var isPlaceholder: Bool = false

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

// MARK: - 6 Categorías del panel

enum RX7Category: String, CaseIterable, Identifiable {
    case aimbotAntena = "AIMBOT CON ANTENA"
    case holoArm = "HOLO ARM"
    case walkHack = "WALK HACK"
    case textura = "TEXTURA"
    case aimbot = "AIMBOT"
    case holoPJ = "HOLO PJ"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .aimbotAntena: return "antenna.radiowaves.left.and.right"
        case .holoArm: return "hand.raised.fill"
        case .walkHack: return "figure.walk"
        case .textura: return "paintbrush.fill"
        case .aimbot: return "scope"
        case .holoPJ: return "person.fill"
        }
    }
}

// Categorías internas (para la lógica de parches)
enum PatchCategory: String, CaseIterable, Identifiable {
    case aimbot = "AIMBOT"
    case hologramas = "HOLOGRAMAS"

    var id: String { rawValue }
}

// MARK: - Registro de toggles

enum RX7Registry {

    static func toggles(for mode: FFMode, category: RX7Category) -> [PatchToggle] {
        switch (mode, category) {

        // MARK: FREE FIRE TH
        case (.normal, .aimbotAntena), (.normal, .aimbot):
            return [
                PatchToggle(
                    id: "aimbot-cabeza-\(category.rawValue)",
                    displayName: "AIMBOT CABEZA",
                    patchFilename: "AIMBOT CABEZA SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-pecho-\(category.rawValue)",
                    displayName: "AIMBOT PECHO",
                    patchFilename: "AIMBOT PECHO SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-cuello-\(category.rawValue)",
                    displayName: "AIMBOT CUELLO",
                    patchFilename: "CUELLO SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimdrag-\(category.rawValue)",
                    displayName: "AIMDRAG",
                    patchFilename: "Avatar_Aimdrag",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "balas-magicas-\(category.rawValue)",
                    displayName: "BALAS MÁGICAS",
                    patchFilename: "AVATAR BALAS MAGICAS SIN ANTENA",
                    icon: "sparkles",
                    category: .aimbot
                ),
            ]

        case (.normal, .holoArm):
            return [
                PatchToggle(
                    id: "holo-arm-th",
                    displayName: "HOLO ARM",
                    patchFilename: "HOLO ARM TH",
                    icon: "hand.raised.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]

        case (.normal, .walkHack):
            return [
                PatchToggle(
                    id: "walk-hack-th",
                    displayName: "WALK HACK",
                    patchFilename: "WALK HACK TH",
                    icon: "figure.walk",
                    category: .aimbot,
                    isPlaceholder: true
                ),
            ]

        case (.normal, .textura):
            return [
                PatchToggle(
                    id: "textura-th",
                    displayName: "TEXTURA",
                    patchFilename: "TEXTURA TH",
                    icon: "paintbrush.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]

        case (.normal, .holoPJ):
            return [
                PatchToggle(
                    id: "holo-basico-th",
                    displayName: "BÁSICO",
                    patchFilename: "BASICO FF NORMAL",
                    icon: "cube.transparent",
                    category: .hologramas
                ),
                PatchToggle(
                    id: "holo-rtx-th",
                    displayName: "RTX",
                    patchFilename: "RTX FF NORMAL",
                    icon: "cube.transparent",
                    category: .hologramas
                ),
                PatchToggle(
                    id: "holo-pj-amarillo-th",
                    displayName: "PJ AMARILLO",
                    patchFilename: "PJ FF NORMAL AMARILLO",
                    icon: "person.fill",
                    category: .hologramas
                ),
            ]

        // MARK: FREE FIRE MAX
        case (.max, .aimbotAntena), (.max, .aimbot):
            return [
                PatchToggle(
                    id: "aimbot-cabeza-\(category.rawValue)-max",
                    displayName: "AIMBOT CABEZA",
                    patchFilename: "CABEZA FF MAX SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-cuello-\(category.rawValue)-max",
                    displayName: "AIMBOT CUELLO",
                    patchFilename: "CUELLO SIN ANTENA FF MAX",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "aimbot-pecho-\(category.rawValue)-max",
                    displayName: "AIMBOT PECHO",
                    patchFilename: "PECHO FF MAX SIN ANTENA",
                    icon: "scope",
                    category: .aimbot,
                    isPlaceholder: true
                ),
                PatchToggle(
                    id: "aimdrag-\(category.rawValue)-max",
                    displayName: "AIMDRAG",
                    patchFilename: "DRAG FF MAX SIN ANTENA",
                    icon: "scope",
                    category: .aimbot
                ),
                PatchToggle(
                    id: "balas-magicas-\(category.rawValue)-max",
                    displayName: "BALAS MÁGICAS",
                    patchFilename: "BALA MAGICA FF MAX",
                    icon: "sparkles",
                    category: .aimbot
                ),
            ]

        case (.max, .holoArm):
            return [
                PatchToggle(
                    id: "holo-arm-max",
                    displayName: "HOLO ARM",
                    patchFilename: "HOLO ARM MAX",
                    icon: "hand.raised.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]

        case (.max, .walkHack):
            return [
                PatchToggle(
                    id: "walk-hack-max",
                    displayName: "WALK HACK",
                    patchFilename: "WALK HACK MAX",
                    icon: "figure.walk",
                    category: .aimbot,
                    isPlaceholder: true
                ),
            ]

        case (.max, .textura):
            return [
                PatchToggle(
                    id: "textura-max",
                    displayName: "TEXTURA",
                    patchFilename: "TEXTURA MAX",
                    icon: "paintbrush.fill",
                    category: .hologramas,
                    isPlaceholder: true
                ),
            ]

        case (.max, .holoPJ):
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

    @State private var selectedCategory: RX7Category = .aimbotAntena
    @State private var activeToggles: Set<String> = []
    @State private var processingToggles: Set<String> = []
    @State private var toast: ToastMessage? = nil
    @State private var showSettings = false
    @State private var alert: PatchStoreAlert? = nil
    @State private var showLogoutConfirmation = false
    @State private var appeared = false

    private var mode: FFMode { session.selectedMode ?? .normal }

    private var toggles: [PatchToggle] {
        RX7Registry.toggles(for: mode, category: selectedCategory)
    }

    var body: some View {
        ZStack {
            rx7Background

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 14) {
                    headerSection
                    editionCard
                    onlineIndicator
                    previewSection
                    categoriesHeader
                    categoriesGrid
                    togglesSection
                    backButton.padding(.top, 8)
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }

            // Widget música flotante
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    RX7MusicWidget()
                        .padding(.trailing, 8)
                        .padding(.bottom, 24)
                }
            }

            // Toast
            if let toast {
                VStack {
                    RX7Toast(
                        title: toast.message,
                        subtitle: "Modo Juego: activado",
                        icon: "rocket.fill"
                    )
                    .padding(.top, 50)
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

    // MARK: - Header

    private var headerSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "shield.lefthalf.filled")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.rx7Cyan)

            Text("RX7 MODZ")
                .font(.system(size: 16, weight: .heavy, design: .rounded))
                .tracking(2)
                .foregroundStyle(LinearGradient(
                    colors: [.rx7Cyan, .rx7Purple],
                    startPoint: .leading,
                    endPoint: .trailing
                ))

            Spacer()

            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.rx7TextSecondary)
                    .frame(width: 36, height: 36)
                    .background(
                        Circle()
                            .fill(Color.rx7Panel.opacity(0.8))
                            .overlay(Circle().stroke(Color.rx7Border, lineWidth: 1))
                    )
            }
        }
    }

    // MARK: - Edición seleccionada

    private var editionCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("EDICIÓN SELECCIONADA")
                .font(.system(size: 8, weight: .bold))
                .tracking(1.2)
                .foregroundStyle(Color.rx7TextSecondary)

            Text(mode.displayName)
                .font(.system(size: 15, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)

            Text("Configuración del panel")
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(Color.rx7TextSecondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .rx7GlassPanel(cornerRadius: 14, isActive: true, accent: .rx7Cyan)
    }

    // MARK: - Sistema en línea

    private var onlineIndicator: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Color.rx7Online)
                .frame(width: 6, height: 6)
                .shadow(color: Color.rx7Online.opacity(0.8), radius: 4)
            Text("Sistema en línea")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.rx7TextSecondary)
        }
    }

    // MARK: - Preview de productos

    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("PREVIEW DE PRODUCTOS")
                .font(.system(size: 8, weight: .bold))
                .tracking(1.2)
                .foregroundStyle(Color.rx7TextSecondary)

            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color.rx7Purple.opacity(0.2))
                        .frame(width: 30, height: 30)
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.rx7Purple)
                }
                VStack(alignment: .leading, spacing: 1) {
                    Text("Disponible pronto:")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundStyle(Color.rx7TextSecondary)
                    Text("MAX")
                        .font(.system(size: 12, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.rx7Purple)
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .rx7GlassPanel(cornerRadius: 14)
    }

    // MARK: - Categorías

    private var categoriesHeader: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("CATEGORÍAS")
                .font(.system(size: 8, weight: .bold))
                .tracking(1.2)
                .foregroundStyle(Color.rx7TextSecondary)

            Text("\(RX7Category.allCases.count) OPCIONES")
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(Color.rx7Cyan.opacity(0.8))
        }
    }

    private var categoriesGrid: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                categoryCard(.aimbotAntena)
                categoryCard(.holoArm)
            }
            HStack(spacing: 8) {
                categoryCard(.walkHack)
                categoryCard(.textura)
            }
            HStack(spacing: 8) {
                categoryCard(.aimbot)
                categoryCard(.holoPJ)
            }
        }
    }

    @ViewBuilder
    private func categoryCard(_ category: RX7Category) -> some View {
        let isSelected = selectedCategory == category

        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedCategory = category
            }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: category.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isSelected ? Color.rx7Cyan : .white)

                Text(category.rawValue)
                    .font(.system(size: 10, weight: .heavy))
                    .tracking(0.3)
                    .foregroundStyle(isSelected ? Color.rx7Cyan : .white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 6)
            .rx7GlassPanel(
                cornerRadius: 16,
                isActive: isSelected,
                accent: .rx7Cyan
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Toggles

    private var togglesSection: some View {
        VStack(spacing: 8) {
            ForEach(toggles) { toggle in
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

    private func subtitleFor(_ toggle: PatchToggle) -> String? {
        if toggle.isPlaceholder && !activeToggles.contains(toggle.id) {
            return "DISPONIBLE PRONTO"
        }
        return activeToggles.contains(toggle.id) ? "ACTIVO" : "TOCA PARA ACTIVAR"
    }

    // MARK: - Volver

    private var backButton: some View {
        Button {
            withAnimation {
                session.selectedMode = nil
                activeToggles.removeAll()
                selectedCategory = .aimbotAntena
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 12, weight: .bold))
                Text("VOLVER")
                    .font(.system(size: 11, weight: .heavy))
                    .tracking(1.2)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(Color.rx7Panel.opacity(0.8))
                    .overlay(Capsule().stroke(Color.rx7Border, lineWidth: 1))
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Lógica toggles

    private func handleToggle(_ toggle: PatchToggle, isOn: Bool) {
        guard !processingToggles.contains(toggle.id) else { return }

        if toggle.isPlaceholder {
            alert = PatchStoreAlert(
                titleKey: "Próximamente",
                messageKey: "\(toggle.displayName) estará disponible pronto."
            )
            return
        }

        if toggle.isBlocked && isOn {
            alert = PatchStoreAlert(
                titleKey: "Opción en mantenimiento",
                messageKey: toggle.blockMessage ?? "No disponible."
            )
            return
        }

        if isOn {
            let conflicts = toggles.filter {
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
                        showToast("Parche no encontrado", icon: "exclamationmark.triangle.fill")
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
                    showToast("Parche activado", icon: "checkmark.circle.fill")
                }
            } catch {
                await MainActor.run {
                    processingToggles.remove(toggle.id)
                    showToast("Error al activar", icon: "exclamationmark.triangle.fill")
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
        for toggle in toggles {
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
            log("panel: \(patches.count) parches dinámicos")
            await patchesStore.downloadAllPatches(patches)
        } catch {
            log("panel: error: \(error)")
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

//
//  TypingSettingsView.swift
//  PHTV
//
//  Created by Phạm Hùng Tiến on 2026.
//  Copyright © 2026 Phạm Hùng Tiến. All rights reserved.
//

import SwiftUI
import AudioToolbox

struct TypingSettingsView: View {
    @EnvironmentObject var appState: AppState

    // Check if restore key conflicts with hotkey
    private var hasRestoreHotkeyConflict: Bool {
        guard appState.restoreOnEscape else { return false }

        switch appState.restoreKey {
        case .esc:
            return false // ESC never conflicts
        case .option:
            return appState.switchKeyOption
        case .control:
            return appState.switchKeyControl
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: LiquidGlass.Metrics.sectionSpacing) {
                // Status Card
                LiquidStatusCard(hasPermission: appState.hasAccessibilityPermission)

                // Input Configuration
                SettingsCard(title: "Cấu hình gõ", icon: "slider.horizontal.3") {
                    VStack(spacing: 0) {
                        // Input Method Row
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color.secondary.opacity(0.12))
                                        .frame(width: 36, height: 36)

                                    Image(systemName: "keyboard.fill")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.secondary)
                                }

                                Text("Phương pháp gõ")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundStyle(LiquidGlass.Colors.textPrimary)
                                
                                Spacer()
                            }

                            Picker("", selection: $appState.inputMethod) {
                                ForEach(InputMethod.allCases) { method in
                                    Text(method.displayName).tag(method)
                                }
                            }
                            .pickerStyle(.segmented)
                            .labelsHidden()
                            .padding(.leading, 52) // 36 (icon) + 16 (spacing)
                        }
                        .padding(.vertical, 8)

                        SettingsDivider()

                        // Code Table Row
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.secondary.opacity(0.12))
                                    .frame(width: 36, height: 36)

                                Image(systemName: "textformat")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.secondary)
                            }
                            
                            Text("Bảng mã")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundStyle(LiquidGlass.Colors.textPrimary)
                            
                            Spacer()

                            Picker("", selection: $appState.codeTable) {
                                ForEach(CodeTable.allCases) { table in
                                    Text(table.displayName).tag(table)
                                }
                            }
                            .labelsHidden()
                            .frame(width: 180)
                        }
                        .padding(.vertical, 8)
                    }
                }

                // Basic Features
                SettingsCard(title: "Tính năng cơ bản", icon: "checklist") {
                    VStack(spacing: 4) {
                        LiquidToggle(
                            title: "Kiểm tra chính tả",
                            subtitle: "Tự động phát hiện lỗi chính tả",
                            icon: "text.badge.checkmark",
                            isOn: $appState.checkSpelling
                        )

                        Divider().padding(.leading, 54).opacity(0.5)

                        LiquidToggle(
                            title: "Khôi phục phím nếu từ sai",
                            subtitle: "Khôi phục ký tự khi từ không hợp lệ",
                            icon: "arrow.uturn.left.circle.fill",
                            isOn: $appState.restoreOnInvalidWord
                        )

                        Divider().padding(.leading, 54).opacity(0.5)

                        LiquidToggle(
                            title: "Tự động nhận diện từ tiếng Anh",
                            subtitle: "Khôi phục từ tiếng Anh (VD: tẻminal → terminal)",
                            icon: "textformat.abc.dottedunderline",
                            isOn: $appState.autoRestoreEnglishWord
                        )
                    }
                }

                // Restore to Raw Keys Feature
                SettingsCard(title: "Phím khôi phục", icon: "arrow.uturn.backward.circle.fill") {
                    VStack(spacing: 16) {
                        LiquidToggle(
                            title: "Khôi phục về ký tự gốc",
                            subtitle: "Khôi phục về ký tự đã gõ trước khi biến đổi",
                            icon: "arrow.uturn.backward.circle.fill",
                            isOn: $appState.restoreOnEscape
                        )

                        if appState.restoreOnEscape {
                            Divider().opacity(0.5)

                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 8) {
                                    Image(systemName: "target")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(.secondary)
                                    
                                    Text("Chọn phím khôi phục")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.secondary)
                                }

                                // Grid of restore keys
                                LazyVGrid(columns: [
                                    GridItem(.flexible(), spacing: 10),
                                    GridItem(.flexible(), spacing: 10),
                                    GridItem(.flexible(), spacing: 10)
                                ], spacing: 10) {
                                    ForEach(RestoreKey.allCases) { key in
                                        LiquidRestoreKeyButton(
                                            key: key,
                                            isSelected: appState.restoreKey == key
                                        ) {
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                                appState.restoreKey = key
                                            }
                                        }
                                    }
                                }

                                // Conflict warning
                                if hasRestoreHotkeyConflict {
                                    HStack(spacing: 10) {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundStyle(.orange)
                                        Text("Phím khôi phục trùng với phím chuyển chế độ")
                                            .font(.caption)
                                            .foregroundStyle(.orange)
                                    }
                                    .padding(10)
                                    .background(Color.orange.opacity(0.1))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                }

                // Enhancement Features
                SettingsCard(title: "Cải thiện gõ", icon: "wand.and.stars") {
                    VStack(spacing: 4) {
                        LiquidToggle(
                            title: "Viết hoa ký tự đầu",
                            subtitle: "Tự động viết hoa sau dấu chấm",
                            icon: "textformat.abc",
                            isOn: $appState.upperCaseFirstChar
                        )

                        Divider().padding(.leading, 54).opacity(0.5)

                        LiquidToggle(
                            title: "Đặt dấu oà, uý",
                            subtitle: "Dấu trên chữ (oà, uý) thay vì dưới (òa, úy)",
                            icon: "a.circle.fill",
                            isOn: $appState.useModernOrthography
                        )

                        Divider().padding(.leading, 54).opacity(0.5)

                        LiquidToggle(
                            title: "Gõ nhanh (Quick Telex)",
                            subtitle: "Gõ cc → ch, gg → gi, kk → kh...",
                            icon: "hare.fill",
                            isOn: $appState.quickTelex
                        )
                    }
                }

                // Advanced Consonants
                SettingsCard(title: "Phụ âm nâng cao", icon: "textformat.abc.dottedunderline") {
                    VStack(spacing: 4) {
                        LiquidToggle(
                            title: "Phụ âm Z, F, W, J",
                            subtitle: "Cho phép nhập các phụ âm ngoại lai",
                            icon: "character",
                            isOn: $appState.allowConsonantZFWJ
                        )

                        Divider().padding(.leading, 54).opacity(0.5)

                        LiquidToggle(
                            title: "Phụ âm đầu nhanh",
                            subtitle: "Gõ f → ph, j → gi, w → qu...",
                            icon: "arrow.right.circle.fill",
                            isOn: $appState.quickStartConsonant
                        )

                        Divider().padding(.leading, 54).opacity(0.5)

                        LiquidToggle(
                            title: "Phụ âm cuối nhanh",
                            subtitle: "Gõ g → ng, h → nh, k → ch...",
                            icon: "arrow.left.circle.fill",
                            isOn: $appState.quickEndConsonant
                        )
                    }
                }
                
                Spacer(minLength: 40)
            }
            .padding(24)
            .frame(maxWidth: 800) // Constrain width for better readability on large screens
        }
    }
}

// MARK: - Specialized Components

struct LiquidStatusCard: View {
    let hasPermission: Bool

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(hasPermission ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                    .frame(width: 56, height: 56)
                
                Image(systemName: hasPermission ? "checkmark.shield.fill" : "exclamationmark.triangle.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(hasPermission ? Color.green : Color.orange)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(hasPermission ? "Sẵn sàng hoạt động" : "Cần cấp quyền")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(LiquidGlass.Colors.textPrimary)

                Text(hasPermission ? "PHTV đang hoạt động bình thường" : "Vui lòng cấp quyền Accessibility để bộ gõ hoạt động")
                    .font(.body)
                    .foregroundStyle(LiquidGlass.Colors.textSecondary)
            }

            Spacer()

            if !hasPermission {
                Button("Cấp quyền") {
                    if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
                        NSWorkspace.shared.open(url)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
        }
        .liquidCard()
    }
}

struct LiquidRestoreKeyButton: View {
    let key: RestoreKey
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(key.symbol)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : .primary)

                Text(shortDisplayName)
                    .font(.caption2)
                    .foregroundStyle(isSelected ? .white.opacity(0.9) : .secondary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.accentColor)
                        .shadow(color: Color.accentColor.opacity(0.4), radius: 8, x: 0, y: 4)
                } else {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.thinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                        )
                }
            }
        }
        .buttonStyle(.plain)
    }

    private var shortDisplayName: String {
        switch key {
        case .esc: return "ESC"
        case .option: return "Option"
        case .control: return "Control"
        }
    }
}

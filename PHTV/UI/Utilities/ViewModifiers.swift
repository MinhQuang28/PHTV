//
//  ViewModifiers.swift
//  PHTV
//
//  Created by Phạm Hùng Tiến on 2026.
//  Copyright © 2026 Phạm Hùng Tiến. All rights reserved.
//

import SwiftUI

// MARK: - Custom View Modifiers for consistent styling

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(NSColor.controlBackgroundColor), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
    }
}

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.top, 8)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
    
    func sectionHeader() -> some View {
        modifier(SectionHeaderStyle())
    }

    // Apply consistent defaults for TextField across the app
    @ViewBuilder
    func settingsTextField() -> some View {
        self.disableAutocorrection(true)
    }

    // Rounded text area style for TextEditor and similar inputs
    func roundedTextArea() -> some View {
        self
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(NSColor.controlBackgroundColor))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.tertiary, lineWidth: 0.5)
                    )
            }
    }
}

// MARK: - Background Extension

struct BackgroundExtensionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(NSColor.windowBackgroundColor))
    }
}

extension View {
    func liquidGlassBackground() -> some View {
        modifier(BackgroundExtensionModifier())
    }
}

// MARK: - Custom Button Styles

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(NSColor.controlBackgroundColor), in: RoundedRectangle(cornerRadius: 6))
            .foregroundColor(.primary)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.tertiary, lineWidth: 0.5)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Animations

extension Animation {
    static let phtv = Animation.easeInOut(duration: 0.25)
    static let phtvSpring = Animation.spring(response: 0.3, dampingFraction: 0.7)
}

// MARK: - Color Extensions

extension Color {
    static let phtvPrimary = Color.accentColor
    static let phtvSecondary = Color(NSColor.secondaryLabelColor)
    static let phtvBackground = Color(NSColor.windowBackgroundColor)
    static let phtvSurface = Color(NSColor.controlBackgroundColor)
}

// MARK: - Adaptive Button Styles

extension View {
    @ViewBuilder
    func adaptiveProminentButtonStyle() -> some View {
        self.buttonStyle(.borderedProminent)
    }

    @ViewBuilder
    func adaptiveBorderedButtonStyle() -> some View {
        self.buttonStyle(.bordered)
    }
}

// MARK: - Settings View Background

/// Applies appropriate background for settings views
/// Uses standard Apple solid background for performance
struct SettingsViewBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(Color(NSColor.windowBackgroundColor))
    }
}

extension View {
    /// Applies appropriate background for settings detail views
    func settingsBackground() -> some View {
        modifier(SettingsViewBackground())
    }

    /// Conditionally applies searchable modifier (macOS 12+)
    @ViewBuilder
    func conditionalSearchable(text: Binding<String>, prompt: String) -> some View {
        self.searchable(text: text, placement: .sidebar, prompt: prompt)
    }

    /// Compatible foregroundStyle - uses foregroundColor on macOS 11
    @ViewBuilder
    func compatForegroundStyle<S: ShapeStyle>(_ style: S) -> some View {
        self.foregroundStyle(style)
    }

    /// Compatible foregroundStyle for HierarchicalShapeStyle
    @ViewBuilder
    func compatForegroundPrimary() -> some View {
        self.foregroundStyle(.primary)
    }

    @ViewBuilder
    func compatForegroundSecondary() -> some View {
        self.foregroundStyle(.secondary)
    }
}

// MARK: - Compatibility Components (Adapters)

struct SettingsCard<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: LiquidGlass.Metrics.elementSpacing) {
            // Header
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .frame(width: 20, height: 20)
                    .offset(y: -0.5) // Optical adjustment
                
                Text(title)
                    .liquidSectionHeader()
            }
            .padding(.bottom, 4)
            .padding(.leading, 4)
            
            // Content
            VStack(spacing: 0) {
                content
            }
            .liquidCard()
        }
    }
}

struct SettingsToggleRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        LiquidToggle(
            title: title,
            subtitle: subtitle,
            icon: icon,
            iconColor: .secondary, // Force Gray/Secondary to match "Off" state style
            isOn: $isOn
        )
    }
}

struct SettingsDivider: View {
    var body: some View {
        Divider()
            .padding(.leading, 54)
            .opacity(0.5)
    }
}

// MARK: - Liquid Glass Design System
// Optimized for performance with solid colors

enum LiquidGlass {
    
    // MARK: - Colors
    // Semantic colors optimized for solid backgrounds
    enum Colors {
        static let tint = Color.accentColor
        static let backgroundTint = Color.clear
        static let secondaryBackground = Color.primary.opacity(0.03)
        static let border = Color.primary.opacity(0.1)
        static let activeBorder = Color.accentColor.opacity(0.3)
        
        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
        static let textTertiary = Color.secondary.opacity(0.7)
    }
    
    // MARK: - Layout Metrics
    enum Metrics {
        static let cornerRadius: CGFloat = 12
        static let cardPadding: CGFloat = 16
        static let elementSpacing: CGFloat = 12
        static let sectionSpacing: CGFloat = 20
    }
}

// MARK: - View Modifiers

struct LiquidBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(NSColor.windowBackgroundColor))
    }
}

struct LiquidCardModifier: ViewModifier {
    var isHovered: Bool = false
    
    func body(content: Content) -> some View {
        content
            .padding(LiquidGlass.Metrics.cardPadding)
            .background {
                ZStack {
                    // Solid background
                    RoundedRectangle(cornerRadius: LiquidGlass.Metrics.cornerRadius, style: .continuous)
                        .fill(Color(NSColor.controlBackgroundColor))
                    
                    // Border
                    RoundedRectangle(cornerRadius: LiquidGlass.Metrics.cornerRadius, style: .continuous)
                        .stroke(
                            isHovered ? LiquidGlass.Colors.activeBorder : LiquidGlass.Colors.border,
                            lineWidth: 1
                        )
                }
            }
    }
}

struct LiquidSectionHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .bold, design: .rounded))
            .foregroundStyle(LiquidGlass.Colors.textSecondary)
            .textCase(.uppercase)
    }
}

// MARK: - Component Extensions

extension View {
    func liquidBackground() -> some View {
        modifier(LiquidBackgroundModifier())
    }
    
    func liquidCard(isHovered: Bool = false) -> some View {
        modifier(LiquidCardModifier(isHovered: isHovered))
    }
    
    func liquidSectionHeader() -> some View {
        modifier(LiquidSectionHeaderModifier())
    }
}

// MARK: - Reusable Components

struct LiquidToggle: View {
    let title: String
    let subtitle: String?
    let icon: String
    var iconColor: Color = .secondary
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon Container
            ZStack {
                Circle()
                    .fill(Color.primary.opacity(0.05))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundStyle(LiquidGlass.Colors.textPrimary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(LiquidGlass.Colors.textSecondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(.switch)
        }
        .padding(.vertical, 6)
    }
}

struct LiquidNavigationLink<Destination: View>: View {
    let title: String
    let icon: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

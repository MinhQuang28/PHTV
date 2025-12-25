# PHTV v1.2.4 Release Notes

## Cải tiến Claude Code Patcher

Phiên bản này cải tiến đáng kể tính năng **Claude Code Patcher** - giúp việc chuyển đổi từ Homebrew sang npm và vá lỗi gõ tiếng Việt ổn định hơn.

### Tính năng mới

#### 🔧 Cải thiện phát hiện Homebrew
- **Tìm brew đa nền tảng**: Tự động tìm brew tại `/opt/homebrew/bin` (Apple Silicon), `/usr/local/bin` (Intel), và Linux
- **Fallback với `which brew`**: Nếu không tìm thấy brew ở các đường dẫn thông thường, sử dụng lệnh `which brew`
- **Nhiều lệnh uninstall**: Thử nhiều cách gỡ Homebrew (với/không `--cask`, với/không `--force`)
- **Xóa symlink thừa**: Tự động xóa symlink còn sót lại sau khi gỡ Homebrew

#### 📦 Hỗ trợ Node.js managers
- **Hỗ trợ fnm**: Ngoài nvm, giờ còn hỗ trợ Fast Node Manager (fnm)
- **PATH đầy đủ**: Build đường dẫn PATH đầy đủ khi chạy npm để tránh lỗi
- **npm prefix cho nvm**: Tự động cấu hình `npm_config_prefix` đúng cho nvm

#### 🛠️ Cài đặt thủ công qua Terminal
- **Nút "Mở Terminal"**: Khi cài đặt tự động thất bại, hiển thị nút mở Terminal với lệnh sẵn
- **Chi tiết lỗi npm**: Hiển thị lỗi npm đầy đủ để debug dễ hơn
- **Hướng dẫn cài thủ công**: Hiển thị lệnh cài đặt thủ công nếu tự động không thành công

### Sửa lỗi

- **Sửa lỗi không tìm thấy brew**: Trước đây hardcode `/opt/homebrew/bin/brew`, giờ tìm động
- **Sửa lỗi npm không chạy được**: Cải thiện environment variables khi gọi npm
- **Sửa lỗi gỡ Homebrew không sạch**: Xử lý các trường hợp symlink còn tồn tại

### Chi tiết kỹ thuật

#### ClaudeCodePatcher.swift
- Thêm `findBrewPath()` - tìm đường dẫn brew đa nền tảng
- Refactor `reinstallFromNpm()` - tách logic thành `installViaAndPatch()`
- Thêm error case `npmInstallFailedWithDetails(String)` với thông tin chi tiết
- Thêm error case `requiresManualInstall(isHomebrew: Bool)` cho cài đặt thủ công
- Thêm `canOpenTerminal` property để xác định lỗi có thể mở Terminal
- Thêm `openTerminalWithInstallCommand()` - mở Terminal với lệnh cài đặt

#### AdvancedSettingsView.swift
- Thêm state `canOpenTerminal` và `wasHomebrewInstall`
- Alert có 2 nút khi có thể mở Terminal: "Mở Terminal" và "Đóng"
- Truyền thông tin lỗi để hiển thị nút phù hợp

### Cách sử dụng

1. Mở **PHTV Settings** > **Tùy chọn nâng cao**
2. Bật toggle **"Hỗ trợ gõ tiếng Việt trong Claude Code"**
3. Nếu Claude Code cài qua Homebrew, PHTV sẽ tự động chuyển sang npm
4. Nếu tự động thất bại, nhấn **"Mở Terminal"** để cài thủ công
5. Khởi động lại Claude Code để áp dụng

### Lưu ý

- Cần cài đặt Node.js/npm để sử dụng tính năng này
- Hỗ trợ nvm và fnm để quản lý Node.js
- Nếu Claude Code cập nhật, có thể cần bật lại toggle để patch phiên bản mới

---

**Full Changelog**: [v1.2.3...v1.2.4](https://github.com/phamhungtien/PHTV/compare/v1.2.3...v1.2.4)

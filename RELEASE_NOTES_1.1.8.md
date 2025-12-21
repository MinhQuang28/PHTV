# PHTV 1.1.8 - Release Notes

## 🎉 Tính năng mới

### Kiểm tra cập nhật tự động từ GitHub
- Tính năng "Kiểm tra cập nhật" giờ kết nối trực tiếp với GitHub API để lấy phiên bản mới nhất
- Tự động timeout sau 30 giây nếu không kết nối được
- Hiển thị link tải xuống trực tiếp từ GitHub Releases
- Không còn phụ thuộc vào file cấu hình cục bộ

## 🐛 Sửa lỗi

### WhatsApp Desktop - Fix hoàn toàn lỗi gõ tiếng Việt
**Vấn đề:** Khi gõ tiếng Việt trong hộp thoại đính kèm (attachment) của WhatsApp Desktop, ký tự đầu của từ bị mất khi gõ nhanh:
- Gõ "chào mừng các bạn" → Hiển thị "c ào  ừng các ạn"

**Giải pháp:** WhatsApp giờ sử dụng cơ chế **Precomposed Unicode + Accessibility API** (giống Spotlight):
- ✅ Không còn phụ thuộc vào timing/độ trễ
- ✅ Thay thế văn bản deterministic qua AX API
- ✅ Ổn định hoàn toàn kể cả khi gõ rất nhanh
- ✅ Không còn lỗi mất ký tự

**Chi tiết kỹ thuật:**
- Chuyển từ Chromium fix (SendShiftAndLeftArrow + Backspace + Send) sang AX API replacement
- Dùng Unicode precomposed thay vì compound characters
- Defer backspace và thay thế text trực tiếp qua Accessibility API

## 🔧 Cải tiến kỹ thuật

- Thêm global function `GetAppDelegateInstance()` để bridge SwiftUI-Objective-C
- Tối ưu timeout handler cho update check
- Cải thiện error handling khi kiểm tra cập nhật

## 📋 Yêu cầu hệ thống

- macOS 14.0 (Sonoma) trở lên
- Quyền Accessibility (Hỗ trợ truy cập)

## 🙏 Cảm ơn

Cảm ơn các bạn đã báo lỗi và góp ý để PHTV ngày càng hoàn thiện hơn!

---

**Download:** [PHTV-1.1.8.dmg](https://github.com/PhamHungTien/PHTV/releases/download/v1.1.8/PHTV-1.1.8.dmg)
**Full Changelog:** https://github.com/PhamHungTien/PHTV/compare/v1.1.7...v1.1.8

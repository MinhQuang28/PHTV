# PHTV v1.2.3 Release Notes

## Cải tiến giao diện báo lỗi & Sửa lỗi Spotlight

Phiên bản này tập trung vào việc tối ưu hiệu suất giao diện báo lỗi và sửa lỗi quan trọng khi gõ tiếng Việt trong Spotlight.

### Sửa lỗi

#### 🔍 Sửa lỗi lặp từ trong Spotlight
- **Sửa lỗi từ bị lặp lại khi restore từ tiếng Anh**: Xử lý chính xác Unicode composed/decomposed khi thay thế text qua AX API
- **Cải thiện timing**: Thêm delay sau khi thay thế text để Spotlight cập nhật internal state
- **Xử lý Unicode combining marks**: Đếm chính xác ký tự base (bỏ qua dấu kết hợp) để tính đúng vị trí cần xóa

#### 🐛 Sửa lỗi giao diện báo lỗi
- **Sửa lỗi lag/không phản hồi khi mở tab báo lỗi**: Chuyển việc tải log sang background thread
- **Sửa lỗi "URL is too long" trên GitHub**: Giảm kích thước nội dung gửi, chỉ gửi thông tin quan trọng
- **Sửa lỗi CPU cao khi gửi báo lỗi**: Giới hạn số log và tối ưu xử lý

### Cải tiến giao diện

#### 📝 Giao diện báo lỗi mới
- **Thiết kế gọn gàng hơn**: Gộp các trường nhập liệu, bỏ header lớn
- **Toggle đồng nhất**: Đổi checkbox thành công tắc (SettingsToggleRow) để đồng bộ với các tab cài đặt khác
- **Form đơn giản**: Chỉ còn 2 trường (tiêu đề và mô tả) thay vì 5 trường như trước
- **Nút gọn hơn**: "Sao chép", "GitHub Issue", "Email" với kích thước nhỏ gọn

#### 🚀 Gửi báo lỗi nhanh hơn
- **Nội dung có sẵn ngay trên GitHub/Email**: Không cần paste thủ công
- **Chỉ gửi thông tin quan trọng**:
  - Tiêu đề và mô tả
  - Thông tin hệ thống: phiên bản PHTV, macOS, kiểu gõ, bảng mã
  - Tối đa 5 lỗi gần nhất (chỉ ERROR và FAULT)
- **Loading indicator**: Hiển thị trạng thái đang xử lý khi gửi báo lỗi

### Cải tiến kỹ thuật

- Sử dụng `async/await` thay vì `DispatchQueue` để tránh block UI
- Cache log đã tải để không phải load lại khi chuyển tab
- Giới hạn thời gian lấy log từ 30 phút xuống 10 phút
- Giới hạn số log entries từ 100 xuống 50
- Tối ưu `buildFormattedOutput` dùng mảng thay vì string concatenation
- Xử lý các Unicode combining mark ranges:
  - `U+0300-U+036F` (Combining Diacritical Marks)
  - `U+1DC0-U+1DFF` (Combining Diacritical Marks Supplement)
  - `U+20D0-U+20FF` (Combining Diacritical Marks for Symbols)
  - `U+FE20-U+FE2F` (Combining Half Marks)

---

**Full Changelog**: [v1.2.2...v1.2.3](https://github.com/phamhungtien/PHTV/compare/v1.2.2...v1.2.3)

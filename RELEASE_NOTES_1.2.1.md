# PHTV v1.2.1 Release Notes

**PHTV — Precision Hybrid Typing Vietnamese**

## Sửa lỗi

### Khôi phục từ tiếng Anh
- **Sửa lỗi nhấn phím mũi tên sau khi restore**: Trước đây khi gõ "tẻminal" rồi nhấn Space để restore thành "terminal", nếu nhấn phím mũi tên trái sẽ bị lỗi thành "tterminal" và mất dấu cách. Đã khắc phục bằng cách reset session ngay sau khi restore.
- **Hỗ trợ viết hoa ký tự đầu**: Khi bật chức năng "Viết hoa ký tự đầu câu", từ tiếng Anh được restore tự động cũng sẽ được viết hoa đúng cách. Ví dụ: "Xin chào. tẻrminal" → "Xin chào. Terminal"

### Spotlight
- **Cải thiện độ ổn định khi gõ nhanh**: Đơn giản hóa xử lý AX API để giảm thiểu lỗi khi gõ nhanh trên Spotlight. Loại bỏ các cơ chế tracking phức tạp gây ra race condition.

## Cải tiến

### Mã nguồn
- Dọn dẹp và đơn giản hóa code xử lý Spotlight
- Loại bỏ các biến và logic không cần thiết

## Yêu cầu hệ thống
- macOS 14.0+ (Sonoma trở lên)
- Apple Silicon (M1, M2, M3, M4)
- Xcode 26.0+ (nếu build từ source)

---

**Full Changelog**: [v1.2.0...v1.2.1](https://github.com/PhamHungTien/PHTV/compare/v1.2.0...v1.2.1)

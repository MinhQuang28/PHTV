# PHTV v1.1.9 Release Notes

## Sửa lỗi

### Macro (Gõ tắt)
- **Fix macro với phím Enter ở chế độ tiếng Anh**: Trước đây macro chỉ hoạt động khi nhấn Space, giờ đã hỗ trợ Enter và các phím khác (dấu phẩy, dấu chấm, v.v.)
- **Fix macro với phím Enter ở chế độ tiếng Việt**: Khắc phục lỗi macro có lúc nhận có lúc không khi nhấn Enter liên tục
- **Reset trạng thái macro đúng cách**: Đảm bảo macro hoạt động ổn định sau mỗi lần sử dụng

### WhatsApp
- **Fix gõ tiếng Việt bị mất chữ**: Khắc phục lỗi khi gõ nhanh bị mất ký tự
- **Fix gạch chân khi gõ**: Loại bỏ hiện tượng gạch chân (underline) xuất hiện khi gõ tiếng Việt
- **Hỗ trợ cả ô chat và caption**: Gõ tiếng Việt mượt mà ở mọi vị trí trong WhatsApp

## Cải tiến kỹ thuật
- Tách WhatsApp ra khỏi nhóm Spotlight-like apps để xử lý riêng biệt
- WhatsApp sử dụng precomposed Unicode với batched sending thay vì AX API
- Bỏ qua SendEmptyCharacter cho WhatsApp để tránh gây lỗi hiển thị

## Cập nhật tài liệu
- README.md được viết lại với đầy đủ tính năng
- Phân loại tính năng theo nhóm rõ ràng
- Thêm bảng phím tắt mặc định

---

**Full Changelog**: [v1.1.8...v1.1.9](https://github.com/PhamHungTien/PHTV/compare/v1.1.8...v1.1.9)

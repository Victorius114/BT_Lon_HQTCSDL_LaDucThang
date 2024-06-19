
Họ và tên: La Đức Thắng
MSSV: K215480106120

1. Đề tài
Tên đề tài: Quản lý vật phẩm trong game Sekiro.
Yêu cầu:
- Tạo cơ sở dữ liệu quản lý vật phẩm trong game Sekiro
- Sắp xếp các vật phẩm theo loại
- Đặt giới hạn số lượng vật phẩm có thể mang theo
- Mua vật phẩm trong cửa hàng
- Riêng với mục nhẫn cụ, trừ số hình nhan mỗi lần sử dụng

2. Thực hiện
- Tạo cơ sở dữ liệu quản lý vật phẩm trong game Sekiro
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/a9d3c086-8de7-4358-ab0f-bfbb37e1623a)

Các dữ liệu sẽ bao gồm tên, công dụng, số lượng và giá tiền mua trong cửa hàng. Riêng với nhẫn cụ sẽ có số hình nhân tiêu tốn mỗi lần sử dụng
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/a10219dd-5cfe-46fb-8017-00fe6ce8912e)
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/e1683752-b2f4-4f4e-b7a9-484bec51f5b1)


Đổi tên hiển thị của cột Description
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/4c950003-710f-46c8-b0df-f6ba2a753e02)

  
- Sắp xếp các vật phẩm theo loại
  Vì tất cả các vật phẩm đều có một cột chung là [Tên] nên chúng ta có thể chọn tên từ các bảng và sắp xếp chúng theo bảng mà chúng thuộc về
  ![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/b64bb8e7-7e67-4fc8-8637-9744e9bd23e1)
  Đầu vào: Tên, Loại
  Đầu ra: Các vật phẩm được sắp xếp theo loại

- Đặt giới hạn số lượng vật phẩm có thể mang theo
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/a0fb5eb9-1935-4dd5-991b-90c0eee95e01)
  Đầu vào: Tên và số lượng vật phẩm được cập nhật

Khi thêm vào quá giới hạn cho phép
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/b51c94b7-938a-40a8-8661-a74dbd6480cb)

Tương tự với các vật phẩm khác
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/e52f678b-6819-4eb6-8549-85212c433a59)

Tạo procedure
  
- Mua vật phẩm trong game
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/43560d9f-dc57-4272-adf0-1aaa2cc8b326)
  Hình ảnh các vật phẩm trong cửa hàng

  Tạo bảng player bao gồm các cột Tên và Tiền
  
  
Tạo procedure
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/c72b2200-4de2-46fd-904a-b5dc5a615208)
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/e4d2f6d0-8f2c-4c1c-951d-2e192464ef1c)
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/c357d29f-5751-4a41-8a8c-94efdfece04e)
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/85d46a4c-4b47-4cc6-8617-4d908325957b)

Đầu vào: Số tiền, Giá tiền
Đầu ra: Số vật phẩm, Số tiền, Giá tiền

Mua hàng thành công
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/76c6e1fa-e1e1-4ef0-b3d1-ecac333d12e6)



 Số tiền đã được trừ
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/42b4bafc-2b90-407e-9e9e-e079e185ef40)

![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/61a07465-04ea-48b1-8fce-e8a99b522767)
Nếu mua quá giới hạn sẽ kích hoạt trigger đã tạo từ trước

Tương tự ta có thể tạo procedure cho mỗi lần sử dụng một nhẫn cụ
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/9738a4fe-1930-4c5e-8926-c47cfef633c4)
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/274e030b-b42c-41a6-9ea4-542ec044be8d)


Sử dụng thành công
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/a9ec07bc-a333-4501-8b30-eb365f06cc41)


Đã trừ số hình nhân
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/4fe2c23f-fef8-4137-8a73-43e62d69fa11)

Không còn hình nhân để sử dụng
![image](https://github.com/Victorius114/BT_Lon_HQTCSDL_LaDucThang/assets/167947119/2856d1d3-1f8a-4593-b96b-96072f1795e2)












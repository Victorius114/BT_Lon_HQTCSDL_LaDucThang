create database Sekiro_items
create table prosthetic_tools
(
	id nvarchar(10) not null
	primary key (id),
	[Tên] nvarchar(max) null,
	[Số_hình_nhân] int not null,
	Description nvarchar(max) null,
	[Số lượng] int 
)

create table item_tang_sm
(
	id nvarchar(10) not null
	primary key (id),
	[Tên] nvarchar(max) null,
	Description nvarchar(max) null,
	[Số lượng] int 
	[Giá tiền] int
)

create table item_hoi_mau
(
	id nvarchar(10) not null
	primary key (id),
	[Tên] nvarchar(max) null,
	Description nvarchar(max) null,
	[Số lượng] int 
	[Giá tiền] int
)

create table item_khang_hieu_ung
(
	id nvarchar(10) not null
	primary key (id),
	[Tên] nvarchar(max) null,
	Description nvarchar(max) null,
	[Số lượng] int 
	[Giá tiền] int
)

--Đổi tên hiển thị của Description:

--prosthetic tools
exec sp_rename 'prosthetic_tools.Description', N'Mô tả', 'column';


--item_tang_sm
exec sp_rename 'item_tang_sm.Description', N'Công dụng', 'column';

--item_hoi_mau
exec sp_rename 'item_hoi_mau.Description', N'Công dụng', 'column';

--item_khang_hieu_ung
exec  sp_rename 'item_khang_hieu_ung.[Tên]', N'Tên', 'column';
exec sp_rename 'item_khang_hieu_ung.Description', N'Công dụng', 'column';

--Sắp xếp các vật phẩm theo loại
SELECT N'Nhẫn cụ' AS [Loại], [Tên]
FROM prosthetic_tools
UNION ALL
SELECT N'Hồi máu' AS [Loại], [Tên]
FROM item_hoi_mau
UNION ALL
SELECT N'Kháng hiệu ứng' AS [Loại], [Tên]
FROM item_khang_hieu_ung
UNION ALL
SELECT N'Tăng sức mạnh' AS [Loại], [Tên]
FROM item_tang_sm
ORDER BY [Loại];

--Giới hạn số các vật phẩm hồi máu có thể mang theo
CREATE TRIGGER heal_items
ON item_hoi_mau
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE [Tên] = N'Hồ lô thương dược' AND [Số lượng] > 10
    )
    BEGIN
        RAISERROR (N'Giới hạn của vật phẩm này là 10', 16, 1);
        ROLLBACK TRANSACTION;
    END
update item_hoi_mau set [Số lượng]=11 where [Tên]=N'Hồ lô thương dược'
	IF EXISTS (
		SELECT 1
		FROM inserted
		WHERE [Tên] = N'Hoàn dược' AND [Số lượng]>3
	)
	BEGIN
        RAISERROR (N'Giới hạn của vật phẩm này là 3', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

--Giới hạn số lượng vật phẩm kháng hiệu ứng có thể mang theo
CREATE TRIGGER powders_lim
ON item_khang_hieu_ung
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE [Số lượng] > 10
    )
    BEGIN
        RAISERROR (N'Giới hạn của vật phẩm này là 10', 16, 1);
        ROLLBACK TRANSACTION;
	END
END;

--Giới hạn số lượng vật tăng sức mạnh có thể mang theo
CREATE TRIGGER buff_lim
ON item_tang_sm
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE [Số lượng] > 3
    )
    BEGIN
        RAISERROR (N'Giới hạn của vật phẩm này là 3', 16, 1);
        ROLLBACK TRANSACTION;
	END
END;

create table player
(
	[Tên] nvarchar(max),
	[Tiền] int
	[Số hình nhân khả dụng] int
)



select*  from player

--Mua hàng
CREATE PROCEDURE MuaHang
    @player nvarchar(50),
    @Ten nvarchar(50),
    @SoLuongMua int
AS
BEGIN
    DECLARE @GiaTien INT;
    DECLARE @SoTienConLai INT;
    DECLARE @TableName nvarchar(50);

    -- Lấy giá tiền của mục cần mua và xác định bảng chứa mục cần mua
    SELECT @GiaTien = [Giá tiền], @TableName = 'item_hoi_mau'
    FROM item_hoi_mau
    WHERE [Tên] = @Ten;
    
    IF @GiaTien IS NULL
    BEGIN
        SELECT @GiaTien = [Giá tiền], @TableName = 'item_khang_hieu_ung'
        FROM item_khang_hieu_ung
        WHERE [Tên] = @Ten;
    END
    
    IF @GiaTien IS NULL
    BEGIN
        SELECT @GiaTien = [Giá tiền], @TableName = 'item_tang_sm'
        FROM item_tang_sm
        WHERE [Tên] = @Ten;
    END

    -- Kiểm tra xem item có tồn tại hay không
    IF @GiaTien IS NULL
    BEGIN
        PRINT N'Tên không tồn tại';
        RETURN;
    END
    
    -- Lấy số tiền hiện tại của người dùng
    SELECT @SoTienConLai = [Tiền]
    FROM player
    WHERE [Tên] = @player;

    -- Kiểm tra xem người dùng có đủ tiền để mua không
    IF @SoTienConLai < @GiaTien * @SoLuongMua
    BEGIN
        PRINT N'Số tiền không đủ để mua';
        RETURN;
    END

    -- Trừ tiền của người dùng
    UPDATE player
    SET [Tiền] = [Tiền] - @GiaTien * @SoLuongMua
    WHERE [Tên] = @player;

    -- Cập nhật số lượng của item trong bảng tương ứng
    IF @TableName = 'item_hoi_mau'
    BEGIN
        UPDATE item_hoi_mau
        SET [Số lượng] = [Số lượng] + @SoLuongMua
        WHERE [Tên] = @Ten;
    END

    IF @TableName = 'item_khang_hieu_ung'
    BEGIN
        UPDATE item_khang_hieu_ung
        SET [Số lượng] = [Số lượng] + @SoLuongMua
        WHERE [Tên] = @Ten;
    END

    IF @TableName = 'item_tang_sm'
    BEGIN
        UPDATE item_tang_sm
        SET [Số lượng] = [Số lượng] + @SoLuongMua
        WHERE [Tên] = @Ten;
    END

    PRINT N'Mua thành công';
END;


EXEC MuaHang @player = N'A', @Ten = N'Kẹo A Công', @SoLuongMua='1';
SELECT* FROM item_tang_sm
SELECT* FROM player

CREATE PROCEDURE NhanCu
    @Ten nvarchar(max),
    @player_name nvarchar(max)
AS
BEGIN
    DECLARE @HinhNhan int;
    DECLARE @HinhNhanKhaDung int;

    -- Lấy số hình nhân từ bảng prosthetic_tools
    SELECT @HinhNhan = [Số hình nhân]
    FROM prosthetic_tools
    WHERE [Tên] = @Ten;

    -- Lấy số hình nhân khả dụng từ bảng player
    SELECT @HinhNhanKhaDung = [Số hình nhân khả dụng]
    FROM player
    WHERE [Tên] = @player_name;

    -- Kiểm tra nếu số hình nhân khả dụng nhỏ hơn 1
    IF @HinhNhanKhaDung < '1'
    BEGIN
        PRINT N'Không còn hình nhân để sử dụng';
        RETURN;
    END

    -- Cập nhật số hình nhân khả dụng của người chơi
    UPDATE player
    SET [Số hình nhân khả dụng] = [Số hình nhân khả dụng] - @HinhNhan
    WHERE [Tên] = @player_name;

    PRINT N'Đã sử dụng nhẫn cụ';
END;


EXEC  NhanCu @Ten=N'Ống phun lửa', @player_name='A'
select*  from player
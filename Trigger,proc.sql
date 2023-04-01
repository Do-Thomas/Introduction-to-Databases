--Tạo trigger: gọi tự động khi có sự kiện thay đổi trên UPDATE, DELETE, INSERT
--Trigger SQL Server được sử dụng để kiểm tra ràng buộc (check constraints) trên nhiều quan hệ (nhiều bảng/table) 
--hoặc trên nhiều dòng (nhiều record) của bảng.
CREATE TRIGGER tên_trigger  
ON { Tên_bảng }   
[ WITH <Options> ]  
{ FOR | AFTER | INSTEAD OF }   
{ [INSERT], [UPDATE] , [DELETE] }
--Nội dung của trigger bắt đầu với từ khóa AS
AS 
BEGIN

END

--Tắt trigger:
DISABLE TRIGGER [schema_name.][trigger_name]
ON [object_name | DATABASE | ALL SERVER]
--Ví dụ
	DISABLE TRIGGER sales.trg_members_insert
	ON sales.members;
-- Tắt tất cả trigger trong bảng SQL
	DISABLE TRIGGER ALL ON table_name;
-- Tắt tất cả trigger trong cơ sở dữ  liệu
	DISABLE TRIGGER ALL ON DATABASE;
-- Bật trigger trong SQL server
	ENABLE TRIGGER [schema_name.][trigger_name]
	ON [object_name | DATABSE | ALL SERVER]
--Ví dụ:
	ENABLE TRIGGER sales.trg_members_insert
	ON sales.members;

-- Liệt kê tất cả trigger trong SQL server
SELECT 
	name,
	is_instead_of_triggrer
FROM
	sys.triggers
WHERE
	type = 'TR';

--Xóa trigger
DROP TRIGGER [ IF EXISTS ] [schema_name.]trigger_name [ ,...n ];
--IF EXISTS : chỉ xóa trigger khi nó đã tồn tại
--schema_name: là tên của lược đồ chứa trigger DML
--trigger_name: tên của trigger mà bạn muốn xóa

DROP TRIGGER [ IF EXISTS ] trigger_name [ ,...n ]   
ON { DATABASE | ALL SERVER };

DROP TRIGGER [ IF EXISTS ] trigger_name [ ,...n ]   
ON ALL SERVER ;


--STORED PROCEDURE 
Create procedure <procedure_Name> (@param_name1 param_type1, @param_name2 param_type2, ..., @param_namen param_typen,)
As 
Begin 
--<SQL Statement> 
END
--Ví dụ
Create proc Print_Emp (@mssv decimal)
As
	Select *
	from tblEmployee
	where empSSN = @mssv

select *
from tblEmployee

exec Print_Emp 30121050004;



-- CURSOR (con trỏ) là một tập hợp kết quả truy vấn (các hàng)
SELECT id,name FROM Product
--Khai báo con trỏ cursorProduct
DECLARE cursorProduct CURSOR FOR
SELECT id, title FROM Product                  -- dữ liệu trỏ tới
Open cursorProduct							   -- mở con trỏ
FETCH NEXT FROM cursorProduct INTO @id, @title -- Đọc dòng đầu tiên
--Nếu 0: thành công, -1: , -2: 
WHILE @@FETCH_STATUS = 0				       --vòng lặp WHILE khi đọc Cursor thành công
BEGIN
--In kết quả hoặc thực hiện bất kỳ truy vấn
--nào dựa trên kết quả đọc được
    PRINT 'ID:' + CAST(@id as nvarchar)
    PRINT 'TITLE:' @title

    FETCH NEXT FROM cursorProduct INTO @it, @title

END
CLOSE cursorProduct
DEALLOCATE cursorProduct


--Function: 
CREATE FUNCTION [schema_name.]function_name 
(
    parameter_list
)
RETURNS data_type AS
BEGIN
    statements
    RETURN value
END
--Return về dạng Table (!= create proc)

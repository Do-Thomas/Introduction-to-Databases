
WITH T AS
(select P.ProductID, P.Name AS ProductName, P.Price,P.ModelID AS ModelName ,PS.Name as SubCategoryName, PS.Category
from Product P LEFT JOIN ProductSubcategory PS
ON P.SubcategoryID = PS.SubcategoryID
WHERE Price<100 and Color='Black')
SELECT T.* 
FROM T left join ProductModel PM
on T.ModelName = PM.ModelID


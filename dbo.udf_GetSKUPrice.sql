USE SQLTest
GO
CREATE FUNCTION dbo.udf_GetSKUPrice(@ID_SKU INT)
RETURNS DECIMAL (18, 2)
AS
BEGIN
	DECLARE @TotalValue DECIMAL(18, 2)
	DECLARE @TotalQuantity DECIMAL (18, 2)

	SELECT @TotalValue = SUM(value)
	FROM dbo.Basket
	WHERE ID_SKU = @ID_SKU

	SELECT @TotalQuantity = SUM(Quantity)
	FROM dbo.Basket
	WHERE ID_SKU = @ID_SKU
	
	RETURN @TotalValue / @TotalQuantity
END
GO
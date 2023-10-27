USE SQLTest
GO
CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT
AS
BEGIN
	IF (SELECT COUNT(*) FROM inserted WHERE inserted.ID_SKU IN
	(SELECT ID_SKU FROM dbo.Basket GROUP BY ID_SKU HAVING COUNT(*) > 1))>1
		BEGIN
		UPDATE dbo.Basket
		SET DiscountValuse = dbo.Basket.Value * 0.05
		FROM dbo.Basket
		JOIN inserted ON dbo.Basket.ID_SKU = inserted.ID_SKU
		END
	ELSE
		BEGIN
		UPDATE dbo.Basket
		SET DiscountValuse = 0
		FROM dbo.Basket
		JOIN inserted on dbo.Basket.ID_SKU = inserted.ID_SKU
		END
END
GO
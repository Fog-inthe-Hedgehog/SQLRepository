USE SQLTest
GO
CREATE VIEW dbo.vw_SKUPrice
AS
SELECT *, dbo.udf_GetSKUPrice(SKU_ID) AS Price
FROM dbo.SKU;
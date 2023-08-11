USE SQLTest
GO
CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
	@FamilySurName VARCHAR(255)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
	BEGIN
		RAISERROR('Семьи с фамилией %s не существует.', 16, 1, @FamilySurName)
		RETURN;
	END;

	UPDATE dbo.Family
	SET BudgetValue = BudgetValue - (Select Sum(Value) 
									From dbo.Basket 
									JOIN dbo.Family ON dbo.Basket.ID_Family = dbo.Family.ID 
									Where Family.SurName = @FamilySurName)
	Where SurName = @FamilySurName;
END;
GO
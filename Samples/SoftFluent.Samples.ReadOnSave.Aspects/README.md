http://www.softfluent.com/Forums/codefluent-entities-(fr)/readrecordonsave

    <cf:entity name="Order" namespace="SoftFluent.Samples.ReadOnSave">
      <cf:property name="Id" key="true" typeName="int" />
      <cf:property name="CreationTime" ca:expression="_trackCreationTime" xmlns:ca="http://www.softfluent.com/aspects/samples/read-on-save" xmlns:cf="http://www.softfluent.com/codefluent/2005/1"  p ersistent="false" readOnSave="true" readOnLoad="true" typeName="datetime" persistenceName="CreationTime" />
    </cf:entity>

The aspect modify the save stored procedure (UPDATE and INSERT statement) to select column with ReadOnSave="true"

    UPDATE [Order] SET
     [Order].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Order].[_trackLastWriteTime] = GETDATE()
        WHERE (([Order].[Order_Id] = @Order_Id) AND ([Order].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Order_Save')
        RETURN
    END
    SELECT DISTINCT [Order].[_rowVersion], 
                    @Order_Id AS 'Order_Id', 
                    _trackCreationTime AS 'CreationTime' -- Added by the aspect
        FROM [Order]
        WHERE ([Order].[Order_Id] = @Order_Id)


    INSERT INTO [Order] (
        [Order].[_trackCreationUser],
        [Order].[_trackLastWriteUser])
    VALUES (
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT @Order_Id = SCOPE_IDENTITY() 
    SELECT DISTINCT [Order].[_rowVersion], 
                    @Order_Id AS 'Order_Id', 
                    _trackCreationTime AS 'CreationTime' -- Added by the aspect
        FROM [Order]
        WHERE ([Order].[Order_Id] = @Order_Id)
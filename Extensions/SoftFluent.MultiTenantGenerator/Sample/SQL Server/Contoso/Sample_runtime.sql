/* CodeFluent Generated Thursday, 04 December 2014 12:02. TargetVersion:Default. Culture:fr-FR. UiCulture:en-GB. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO

DECLARE @error int
SELECT @error = error FROM master..sysmessages where error = 50001
IF @@ROWCOUNT = 1 EXEC sp_dropmessage @msgnum = 50001, @lang = 'us_english'
EXEC sp_addmessage @msgnum = 50001, @severity = 16, @msgtext = 'Concurrency error in procedure %s', @lang = 'us_english'
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION' AND ROUTINE_NAME = 'cf_quotename')
DROP FUNCTION [dbo].[cf_quotename]
GO
CREATE FUNCTION [dbo].[cf_quotename](@s nvarchar(max)) RETURNS nvarchar(max) AS
BEGIN
  DECLARE @r nvarchar(max), @c  char(1)
  SELECT @c = ''''
  SELECT @r = replace(@s, @c, @c + @c)
  RETURN (@c + @r + @c)
END
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION' AND ROUTINE_NAME = 'cf_SplitString')
DROP FUNCTION [dbo].[cf_SplitString]
GO
CREATE FUNCTION [dbo].[cf_SplitString](@s nvarchar(max), @c nchar) RETURNS @t TABLE (Item nvarchar(max)) AS
BEGIN
  IF @s IS NULL RETURN
  DECLARE @p int, @current int
  SET @current = 1
  WHILE (1 = 1)
  BEGIN
      SET @p = charindex(@c, @s, @current)
      IF (@p = 0)
      BEGIN
          IF ((LEN(@s) - @current + 1) > 0)
          BEGIN
              INSERT INTO @t VALUES(substring(@s, @current, LEN(@s) - @current + 1))
          END
          RETURN
      END
      ELSE
      BEGIN
          INSERT INTO @t VALUES(substring(@s, @current, @p - @current))
          SET @current = @p + 1
      END
  END
  RETURN
END
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION' AND ROUTINE_NAME = 'cf_modelVersion')
DROP FUNCTION [dbo].[cf_modelVersion]
GO
CREATE FUNCTION [dbo].[cf_modelVersion]() RETURNS int AS
BEGIN
  RETURN -38755370
END
GO


show con_name;
select name from v$containers;
alter session set container=freepdb1;
show con_name;
alter pluggable database freepdb1 open;
Create Table Asset(
aId integer primary key,
aName nvarchar2(50) not null unique,
aPrice number(12,2) default(0) not null
);
desc Asset;

Create or Replace Procedure udp_Asset_insert(
id Asset.aId%TYPE, name Asset.aName%Type, price Asset.aPrice%Type)
as
Begin
    insert into Asset(aId,aName,aPrice) values(id,name,price);
    dbms_output.put_line('Asset inserted successfully.');
End;

set serveroutput on;
exec udp_asset_insert(2,'Tables',15000);

Create or Replace Procedure udp_Asset_Update(
id Asset.aId%TYPE, name Asset.aName%Type, price Asset.aPrice%Type
)
As
Begin
    Update Asset Set aName=name,aPrice=price Where aId=id;
End;

Create Or Replace Procedure udp_Asset_Remove(
id IN Asset.aId%TYPE
)
Is
Begin
   Delete From Asset Where aId=id;
   dbms_output.put_line('Asset removed.');
End;

Create or Replace Procedure udp_getAllAsset
as
Begin
   DBMS_OUTPUT.PUT_LINE('Asset Record:');
   For a in(Select AID,ANAME,APRICE  from Asset)
   Loop
      dbms_output.put_line(a.aId||'.   '||a.aName||'    '||a.aprice);
   End Loop;
End;

Begin
  udp_getallasset;
End;
//WASP to get the count of record in the Asset table.
Create Or Replace Procedure udp_getAssetCount(c OUT int)
as
Begin
    select count(*) into c From Asset;
End;

DECLARE
  c integer;
Begin
  udp_getAssetCount(c);
  If c<10 Then
  DBMS_OUTPUT.PUT_LINE('You are poor at your asset record.');
  Else
     DBMS_OUTPUT.PUT_LINE('Your asset record is satisfactory.');
  End If;
  DBMS_OUTPUT.PUT_LINE('No. of Assets: '||c);
End;

Create or Replace Function udf_getSquare(n int)
return int
as
Begin
  return n*n;
End;

select udf_getSquare(5) from dual;
select aId,aName,aPrice,udf_getSquare(aId) IdSquare From Asset;

Create or replace function udf_getVat(
id Asset.aId%TYPE)
return Asset.aId%TYPE
as
vat number;
Begin
   select aPrice*.13 into vat From Asset Where aId=id;
   return vat;
End;

select aId,aName,aPrice,udf_getvat(aId) as VAT from asset;
----q10--
DELETE FROM [ProductInventory]
      WHERE LocationID = (
	  select distinct l.LocationID
		from  ProductInventory pn 
		 join Location l on pn.LocationID = l.LocationID
		 where l.Name = 'Tool Crib'
	  )
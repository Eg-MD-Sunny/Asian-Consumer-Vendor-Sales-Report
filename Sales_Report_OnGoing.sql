---OnGoing

SELECT 
	Cast(DBO.ToBdt(Shipment.reconciledon)as date) DeliveryDate,
	ProductVariant.Id ProductVariantId,
	ProductVariant.Name ProductVariantName,
	ThingRequest.SalePrice SalePrice,
	COUNT (ProductVariant.Id) Quantity
	


FROM
	ProductVariant
	Join ThingRequest on ThingRequest.ProductVariantId = ProductVariant.Id
	Join Thing on ThingRequest.AssignedThingId = Thing.Id
	Join Shipment on ThingRequest.ShipmentId = Shipment.Id


WHERE
	ProductVariant.Id in (16297,27207,2191,16292,6711,6710,27418,21630)

	and Shipment.ReconciledOn >= '2022-02-13 00:00 +06:00'
	and Shipment.ReconciledOn  < '2022-03-01 00:00 +06:00'
	and ThingRequest.Mrp <> ThingRequest.ListPrice
	and Shipment.ShipmentStatus in (8)
	and ThingRequest.IsReturned = 0
	and ThingRequest.IsCancelled = 0
	and ThingRequest.HasFailedBeforeDispatch =0
	and ThingRequest.IsMissingAfterDispatch = 0
	and Thing.CostPrice is not NULL
	and Shipment.ReconciledOn is not NULL
	
GROUP BY
	Cast(DBO.ToBdt(Shipment.reconciledon)as date),
	ProductVariant.Id ,
	ProductVariant.Name,
	ThingRequest.SalePrice
Order by 
	ProductVariantId




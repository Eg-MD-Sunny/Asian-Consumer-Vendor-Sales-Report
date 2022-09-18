---Already Close

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
	ProductVariant.Id in (3074,6710,6711,12076,16292,19869,21630,27183,27186,27187,27188,27198,27199,27200,27201,27206,27391)

	and Shipment.ReconciledOn >= '2021-12-01 00:00 +06:00'
	and Shipment.CreatedOn  < '2022-01-01 00:00 +06:00'
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




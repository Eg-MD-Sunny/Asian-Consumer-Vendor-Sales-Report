-- Vendor Claim
SELECT 
	cast(dbo.ToBdt(Shipment.ReconciledOn)as date) [Delivery Date],
	ProductVariant.Id [PVID],
	ProductVariant.Name [Product],
	SUM(ThingRequest.SalePrice) [SalePrice],
	COUNT (ProductVariant.Id) [Quantity],
	SUM(ThingRequest.SalePrice)*COUNT (ProductVariant.Id) [TotalSalePrice]


FROM
	ProductVariant
	Join ThingRequest on ThingRequest.ProductVariantId = ProductVariant.Id
	Join Thing on ThingRequest.AssignedThingId = Thing.Id
	Join Shipment on ThingRequest.ShipmentId = Shipment.Id


WHERE 
	ProductVariant.Id in (28251,30279,21402,16293,19869,21399,2194,27198,27199,27200,27201,27204,27205,3371,27207,2191,27189,12076,27418,27420,24352)

	and Shipment.ReconciledOn >= '2022-06-01 00:00 +06:00'
	and Shipment.CreatedOn  < '2022-07-01 00:00 +06:00'				-- When Offer is Closed
	and ThingRequest.Mrp <> ThingRequest.ListPrice
	and Shipment.ShipmentStatus in (8)
	and ThingRequest.IsReturned = 0
	and ThingRequest.IsCancelled = 0
	and ThingRequest.HasFailedBeforeDispatch =0
	and ThingRequest.IsMissingAfterDispatch = 0
	and Thing.CostPrice is not NULL
	and Shipment.ReconciledOn is not NULL
	
GROUP BY
	cast(dbo.ToBdt(Shipment.ReconciledOn)as date),
	ProductVariant.Id,
	ProductVariant.Name,
	Shipment.OrderId




--========================================================
--========================================================

SELECT 
	cast(dbo.ToBdt(Shipment.ReconciledOn)as date) [Delivery Date],
	ProductVariant.Id [PVID],
	ProductVariant.Name [Product],
	SUM(ThingRequest.SalePrice) [SalePrice],
	COUNT (ProductVariant.Id) [Quantity],
	SUM(ThingRequest.SalePrice)*COUNT (ProductVariant.Id) [TotalSalePrice]
	
FROM
	ProductVariant
	Join ThingRequest on ThingRequest.ProductVariantId = ProductVariant.Id
	Join Thing on ThingRequest.AssignedThingId = Thing.Id
	Join Shipment on ThingRequest.ShipmentId = Shipment.Id


WHERE
	ProductVariant.Id in (28251,30279,21402,16293,19869,21399,2194,27198,27199,27200,27201,27204,27205,3371,27207,2191,27189,12076,27418,27420,24352)

	and Shipment.ReconciledOn >= '2022-05-25 00:00 +06:00'
	and Shipment.ReconciledOn  < '2022-06-01 00:00 +06:00'				-- When Offer is on going
	and ThingRequest.Mrp <> ThingRequest.ListPrice
	and Shipment.ShipmentStatus in (8)
	and ThingRequest.IsReturned = 0
	and ThingRequest.IsCancelled = 0
	and ThingRequest.HasFailedBeforeDispatch =0
	and ThingRequest.IsMissingAfterDispatch = 0
	and Thing.CostPrice is not NULL
	and Shipment.ReconciledOn is not NULL
	
GROUP BY
	cast(dbo.ToBdt(Shipment.ReconciledOn)as date),
	ProductVariant.Id,
	ProductVariant.Name,
	Shipment.OrderId


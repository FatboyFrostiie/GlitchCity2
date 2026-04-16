local ShopController = {}

function ShopController:handlePurchase(player, itemId)
    -- Your purchase handling logic here
    print(player.Name .. " purchased item with ID: " .. itemId)
    
    -- Add more functionality as needed for your shop
end

return ShopController
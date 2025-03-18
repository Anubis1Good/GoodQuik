local price = 100
local quantity = 1
local function main()
    local result = sendTransaction({
        CLASSCODE = 'SPBFUT',
        SECCODE = 'MMH5',
        ACTION = "NEW_ORDER",
        OPERATION = "B",
        PRICE = tostring(price),
        QUANTITY = tostring(quantity)
    })
end
-- Parameters for canceling all orders
local class_code = "SPBFUT"  -- Class code
local sec_code = "MMH5"    -- Security code
local client_code = "SPBFUT17OVS"   -- Security code


local function kill_order(num_order)
    local transaction_id = sendTransaction({
        CLASSCODE = class_code,
        SECCODE = sec_code,
        ACTION = "KILL_ORDER",
        ORDER_KEY = tostring(num_order),
        TRANS_ID="8",
    })
    message(transaction_id) 
end

local function func(t)
    return t.sec_code == sec_code and t.flags % 2 ~= 0
end
-- Perform the search
local function kill_order_all()
    local results = SearchItems('orders',0,getNumberOf("orders")-1,func)
    
    -- Check if results were found
    if not results then
        -- message("No instruments found")
        return
    else
        for i, v in ipairs(results) do
            r = getItem('orders',v)
            num_order = r.order_num
            kill_order(num_order)
        end
    end
    
end

-- function decimalToBinary(n)
--     if n == 0 then
--         return "0"
--     end
--     local is_negative = n < 0
--     n = math.abs(n)  -- Работаем с положительным числом
--     local binary = ""
--     while n > 0 do
--         binary = tostring(n % 2) .. binary
--         n = math.floor(n / 2)
--     end
--     if is_negative then
--         binary = "-" .. binary
--     end
--     return binary
-- end
-- r = getItem('orders',4)
-- numder_order = r.flags
-- message('no '..numder_order)
-- numder_order = decimalToBinary(numder_order)
-- message('noband '..numder_order)

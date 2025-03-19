local p_classcode = "SPBFUT"
local p_seccode = "MMM5"
local quantity = 1
local threshold = 30

-- Заяка на покупку
local function get_bbid(p_classcode, p_seccode)
    if ParamRequest(p_classcode, p_seccode, "bid")==true then
        bid = getParamEx2(p_classcode, p_seccode, "bid")
        return bid.param_value
    end
end

-- Заяка на продажу
local function get_bask(p_classcode, p_seccode)
    if ParamRequest(p_classcode, p_seccode, "offer")==true then
        ask = getParamEx2(p_classcode, p_seccode, "offer")
        return ask.param_value
    end
end

local function buy(quantity)
    local price = get_bbid(p_classcode,p_seccode)
    price = string.format("%.2f", price)
    local result = sendTransaction({
        CLASSCODE = p_classcode,
        SECCODE = p_seccode,
        ACTION = "NEW_ORDER",
        OPERATION = "B",
        PRICE = tostring(price),
        QUANTITY = tostring(quantity),
        TRANS_ID="9",
        ACCOUNT="SPBFUT17OVS",
    })
    -- message('r '..result)
end

local function sell(quantity)
    local price = get_bask(p_classcode,p_seccode)
    price = string.format("%.2f", price)
    local result = sendTransaction({
        CLASSCODE = p_classcode,
        SECCODE = p_seccode,
        ACTION = "NEW_ORDER",
        OPERATION = "S",
        PRICE = tostring(price),
        QUANTITY = tostring(quantity),
        TRANS_ID="7",
        ACCOUNT="SPBFUT17OVS",
    })
    
end

local function kill_order(num_order)
    local transaction_id = sendTransaction({
        CLASSCODE = p_classcode,
        SECCODE = p_seccode,
        ACTION = "KILL_ORDER",
        ORDER_KEY = tostring(num_order),
        TRANS_ID="8",
    })
    -- message(transaction_id) 
end

local function func(t)
    return t.sec_code == p_seccode and t.flags % 2 ~= 0
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

local function get_lots()
    local lots = 0
    local n = getNumberOf("futures_client_holding")
    local futures_client_holding={}                    
    for i=0,n-1 do            
       futures_client_holding = getItem("futures_client_holding", i)
       if tostring(futures_client_holding["sec_code"])==p_seccode then
          lots=tonumber(futures_client_holding["totalnet"])
       end
    end      
    return lots
end

local function get_action()
    local x = getNumCandles('MXI')
    local MXI_t, MXI_n, MXI_name = getCandlesByIndex('MXI', 0, 0, x)
    local row = MXI_t[MXI_n-1]
    local indicator_id = "MXI_RSI"  -- Идентификатор индикатора (RSI)
    local x = getNumCandles(indicator_id)
    local rsis, a, b = getCandlesByIndex(indicator_id , 0, 0, x)
    local rsi = rsis[a-1].close
    local indicator_id = "MXI_PC"  -- Идентификатор индикатора (RSI)
    local x = getNumCandles(indicator_id)
    local uppers, a, b = getCandlesByIndex(indicator_id , 0, 0, x)
    -- local middles, a, b = getCandlesByIndex(indicator_id , 1, 0, x)
    local lowers, a, b = getCandlesByIndex(indicator_id , 2, 0, x)
    local upper = uppers[a-1].close
    local lower = lowers[a-1].close
    local nearest_long = row['high'] - row['close'] > row['close'] - row['low'] 
    if row['low'] == lower then
        if nearest_long then
            if rsi < threshold then
                return 'long_pw'
            end
            
        end
    end
    if row['high'] == upper then
        if rsi > 100-threshold then
            return 'short_pw'
            
        end
    end
    return 'None'

end
-- local lots = get_lots()
-- buy(quantity+math.abs(lots))
-- message('a '..quantity+math.abs(lots))
local is_run = true
function main()
    while is_run do
        kill_order_all()
        local action = get_action()
        if action ~= 'None' then 
            local lots = get_lots()
            message('action '..action..' lots '..lots)
            if action == 'long_pw' then
                if lots > 0 then
                    goto continue
                else
                    buy(quantity+math.abs(lots))
                end
            else
                if lots < 0 then
                    goto continue
                else
                    sell(quantity+lots)
                end
                
            end
        end
        ::continue::
        sleep(5000)
    end
end
function OnStop(stop_flag)              
    is_run=false
end
-- main()
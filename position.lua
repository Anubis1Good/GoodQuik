-- Parameters
local class_code = "SPBFUT"  -- Class code
local sec_code = "MMH5"    -- Security code
local client_code = "SPBFUT17OVS"     -- Client code (если не указан, используется текущий клиентский код)

local function get_lots()
    local lots = 0
    local n = getNumberOf("futures_client_holding")
    local futures_client_holding={}                    
    for i=0,n-1 do            
       futures_client_holding = getItem("futures_client_holding", i)
       if tostring(futures_client_holding["sec_code"])==sec_code then
          lots=tonumber(futures_client_holding["totalnet"])
       end
    end      
    return lots
end

local lots = get_lots()
message('lots'..lots)
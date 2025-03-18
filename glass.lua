-- Параметры инструмента
local p_classcode = "SPBFUT"
-- local p_classcode = "RFUD"
local p_seccode = "SiH5"
local p_seccode = "MMH5"
-- local p_classcode = "TQBR"
-- local p_seccode = "SBER"
-- Заяка на покупку
if ParamRequest(p_classcode, p_seccode, "bid")==true then
    bid = getParamEx2(p_classcode, p_seccode, "bid")
    -- message(bid.param_value,1)
    message(bid.param_value)
end
-- Заяка на продажу
if ParamRequest(p_classcode, p_seccode, "offer")==true then
    ask = getParamEx2(p_classcode, p_seccode, "offer")
    -- message(ask.param_value,1)
    message(ask.param_value)
end
-- function main()
--     while true do
        -- if ParamRequest(p_classcode, p_seccode, "bid")==true then
        -- bid = getParamEx2(p_classcode, p_seccode, "bid")
        -- message(bid.param_value,1)
        -- sleep(5000)
--     end
--    end
-- end
-- Quotes = getQuoteLevel2(p_classcode, p_seccode)
-- message('len'..#Quotes)  
-- function main()
--     Subscribe_Level_II_Quotes(class, sec)
--     -- Получаем актуальные котировки, если они есть:
--     Quotes = getQuoteLevel2(class, sec)
--     message('len'..#Quotes)
-- end
-- -- Дальнейшие изменения в стакане можно ловить в OnQuote:
-- function OnQuote(class, sec)
--     Quotes = getQuoteLevel2(class, sec)
--     message('len'..#Quotes)
--   end
-- local bids, asks = getQuoteLevel2(class_code, sec_code)

-- -- Проверяем, удалось ли получить данные
-- if not bids or not asks then
--     message("Not bids" .. sec_code)
--     return
-- end

-- -- Лучшая цена покупки (лучший бид)
-- if #bids > 0 then
--     local best_bid = bids[1]
--     message(string.format("Best Bid: Цена=%.2f, Количество=%d, Заявок=%d",
--         best_bid.price, best_bid.quantity, best_bid.orders_count))
-- else
--     message("Нет заявок на покупку")
-- end

-- -- Лучшая цена продажи (лучший аск)
-- if #asks > 0 then
--     local best_ask = asks[1]
--     message(string.format("Best ASK: Цена=%.2f, Количество=%d, Заявок=%d",
--         best_ask.price, best_ask.quantity, best_ask.orders_count))
-- else
--     message("Нет заявок на продажу")
-- end
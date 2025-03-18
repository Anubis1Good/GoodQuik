-- Получаем количество свечей на графике 'MXI'
-- local x = getNumCandles('MXI')
-- if x == 0 then
--     message("There are no candles on the MXI chart")
--     return
-- end

-- -- Получаем данные по свечам
-- local MXI_t, MXI_n, MXI_name = getCandlesByIndex('MXI', 0, 0, x)
-- if not MXI_t or MXI_n == 0 then
--     message("couldn't get the MXI chart")
--     return
-- end
-- local indicator_id = "MXI_RSI"  -- Идентификатор индикатора (RSI)
-- local x = getNumCandles(indicator_id)
-- local rsi, a, b = getCandlesByIndex(indicator_id , 0, 0, x)
-- message('a='..a)
local indicator_id = "MXI_PC"  -- Идентификатор индикатора (RSI)
local x = getNumCandles(indicator_id)
local pc, a, b = getCandlesByIndex(indicator_id , 0, 0, x)
message('a='..a)
local pc_last = pc[a-1].close
message('pc_last='..pc_last)
local pc, a, b = getCandlesByIndex(indicator_id , 1, 0, x)
message('a='..a)
local pc_last = pc[a-1].close
message('pc_last='..pc_last)
local pc, a, b = getCandlesByIndex(indicator_id , 2, 0, x)
message('a='..a)
local pc_last = pc[a-1].close
message('pc_last='..pc_last)

-- local length = #rsi
-- Выводим информацию о графике


-- Выводим данные по последним 20 свечам (или всем, если их меньше 20)
-- local start_index = math.max(1, MXI_n - 19)  -- Начинаем с 20-й свечи с конца
-- for i = start_index, MXI_n-1 do
--     local candle = MXI_t[i]
--     message(string.format(
--         "Candel %d: Time=%s, Open=%.2f, High=%.2f, Low=%.2f, Close=%.2f, Volume=%d",
--         i, candle.datetime, candle.open, candle.high, candle.low, candle.close, candle.volume
--     ))
-- end

-- -- Получаем данные последней свечи
-- local last_candle = MXI_t[MXI_n-1]
-- if last_candle then
--     local H = last_candle.high
--     local L = last_candle.low
--     local O = last_candle.open
--     local C = last_candle.close
--     local V = last_candle.volume
--     local RSI = rsi[a-1].close
--     -- Выводим данные последней свечи
--     message(string.format(
--         "Last Candel: H=%.2f, L=%.2f, O=%.2f, C=%.2f, V=%d, RSI=%.2f",
--         H, L, O, C, V, RSI
--     ))
-- else
--     message("There is no data about the last candle")
-- end
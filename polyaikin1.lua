x = getNumCandles('MXI')
MXI_t,MXI_n,MXI_name = getCandlesByIndex('MXI',0,0,x)

H = MXI_t[MXI_n-1].high
L = MXI_t[MXI_n-1].low
O = MXI_t[MXI_n-1].open
C = MXI_t[MXI_n-1].close
V = MXI_t[MXI_n-1].volume

message('H='..H..'V='..V)
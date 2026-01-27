# Код программы

``` {.julia xleftmargin=1em,linenos}
using Pkg
Pkg.add("DifferentialEquations")
using DifferentialEquations

pr = 0.0 # initial value of the drop function
T = 0.5 # round-trip time, RTT
N = 60.0 # number of TCP sessions
c = 10.0 # service intensity, Mbps
packet_size = 500.0 # package size, bit
C = 125000.0*c / packet_size # service intensity, packets
wq = 0.0004 # EWMS parameter
q_min = 0.25 # minimum queue threshold
q_max = 0.50 # maximum queue threshold
R = 300.0 # queue size
p_max = 0.1 # maximum drop probability
w_max = 32.0 #maximum window size
p = (T, N, C, wq, q_min, q_max, R, p_max, w_max) # vector of system parameters
```


Klicky repeatability testing across different speeds.

# Test Procedure
1. G32
2. G1 X175 Y175 Z10 
3. set hotend to 200C, bed to 60C
4. wait for chamber to get to 26C
5. turn heaters off
6. run M48 S25 (25 sample test) 5 times, record results
7. let everything cool to below 40C and start over

# Probe 1 results

## 1 mm/s (1):
1. G32 bed probe heights: 0.095 0.100 0.102 0.102 0.102 0.101 0.100 0.100 0.100 0.101 0.102 0.100 0.099 0.097 0.096 0.095 0.095 0.093 0.091 0.087 0.087 0.087 0.085 0.084, mean 0.096, deviation from mean 0.006
2. G32 bed probe heights: 0.138 0.141 0.141 0.141 0.140 0.140 0.138 0.138 0.138 0.135 0.135 0.135 0.134 0.132 0.132 0.131 0.134 0.134 0.131 0.129 0.127 0.127 0.127 0.125, mean 0.134, deviation from mean 0.005
3. G32 bed probe heights: 0.121 0.126 0.127 0.127 0.127 0.125 0.125 0.123 0.123 0.123 0.120 0.120 0.120 0.119 0.117 0.117 0.119 0.120 0.119 0.117 0.117 0.117 0.117 0.117, mean 0.121, deviation from mean 0.004
4. G32 bed probe heights: 0.110 0.114 0.116 0.119 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.120 0.123 0.123 0.123 0.123, mean 0.120, deviation from mean 0.003
5. G32 bed probe heights: 0.114 0.117 0.119 0.120 0.120 0.120 0.120 0.123 0.125 0.124 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.120 0.120, mean 0.121, deviation from mean 0.002

## 2 mm/s (3): 
1. G32 bed probe heights: 0.093 0.093 0.093 0.095 0.095 0.095 0.097 0.097 0.097 0.097 0.097 0.096 0.095 0.093 0.093 0.093 0.093 0.093 0.093 0.093 0.090 0.090 0.089 0.087, mean 0.094, deviation from mean 0.003
2. G32 bed probe heights: 0.084 0.086 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.089 0.089 0.089 0.087 0.085 0.085 0.085 0.085 0.084 0.083 0.083 0.083 0.083 0.083, mean 0.086, deviation from mean 0.002
3. G32 bed probe heights: 0.074 0.075 0.078 0.078 0.078 0.078 0.078 0.078 0.078 0.076 0.076 0.078 0.079 0.080 0.078 0.078 0.078 0.078 0.078 0.078 0.078 0.078 0.078 0.078, mean 0.077, deviation from mean 0.001
4. G32 bed probe heights: 0.074 0.078 0.080 0.080 0.080 0.081 0.083 0.083 0.084 0.085 0.085 0.085 0.085 0.085 0.085 0.085 0.085 0.085 0.085 0.084 0.084 0.083 0.083 0.083, mean 0.083, deviation from mean 0.003
5. G32 bed probe heights: 0.078 0.080 0.083 0.083 0.083 0.083 0.083 0.083 0.083 0.083 0.084 0.085 0.087 0.085 0.085 0.085 0.085 0.085 0.085 0.085 0.085 0.085 0.083 0.083, mean 0.083, deviation from mean 0.002

## 5 mm/s (5):
1. G32 bed probe heights: 0.072 0.078 0.078 0.078 0.078 0.078 0.083 0.083 0.083 0.083 0.083 0.083 0.083 0.083 0.083 0.078 0.078 0.078 0.078 0.078 0.078 0.078 0.078 0.078, mean 0.079, deviation from mean 0.003
2. G32 bed probe heights: 0.130 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.138 0.132 0.138 0.132 0.132 0.132 0.132, mean 0.136, deviation from mean 0.002
3. G32 bed probe heights: 0.123 0.127 0.127 0.127 0.130 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.132 0.127 0.127 0.127 0.127 0.127, mean 0.130, deviation from mean 0.003
4. G32 bed probe heights: 0.123 0.123 0.123 0.123 0.123 0.123 0.125 0.127 0.123 0.125 0.125 0.125 0.125 0.123 0.123 0.123 0.123 0.125 0.127 0.127 0.127 0.127 0.127 0.127, mean 0.125, deviation from mean 0.002
5. G32 bed probe heights: 0.117 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.123 0.125, mean 0.122, deviation from mean 0.001

# Probe 2 results

## 1 mm/s (2):
1. G32 bed probe heights: 0.081 0.085 0.085 0.085 0.085 0.085 0.084 0.083 0.083 0.081 0.080 0.079 0.078 0.078 0.076 0.075 0.074 0.072 0.075 0.074 0.072 0.071 0.071 0.068, mean 0.078, deviation from mean 0.005
2. G32 bed probe heights: 0.051 0.054 0.055 0.055 0.054 0.054 0.054 0.052 0.055 0.055 0.054 0.052 0.051 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.051, mean 0.052, deviation from mean 0.002
3. G32 bed probe heights: 0.044 0.047 0.049 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.051 0.052 0.052 0.052 0.052 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.050, mean 0.050, deviation from mean 0.002
4. G32 bed probe heights: 0.044 0.046 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.046 0.045 0.045 0.045 0.047 0.049 0.047 0.047 0.047 0.047 0.046 0.045, mean 0.047, deviation from mean 0.001
5. G32 bed probe heights: 0.032 0.036 0.041 0.043 0.040 0.040 0.040 0.040 0.040 0.040 0.040 0.040 0.040 0.040 0.039 0.038 0.038 0.038 0.038 0.039 0.043 0.043 0.041 0.040, mean 0.039, deviation from mean 0.002

## 2 mm/s (4):
1. G32 bed probe heights: 0.081 0.084 0.087 0.087 0.089 0.089 0.089 0.087 0.087 0.087 0.085 0.085 0.085 0.083 0.083 0.083 0.084 0.085 0.085 0.084 0.083 0.083 0.083 0.081, mean 0.085, deviation from mean 0.002
2. G32 bed probe heights: 0.071 0.072 0.072 0.072 0.072 0.072 0.072 0.072 0.072 0.072 0.072 0.071 0.070 0.070 0.070 0.069 0.068 0.068 0.070 0.070 0.070 0.069 0.068 0.068, mean 0.071, deviation from mean 0.002
3. G32 bed probe heights: 0.050 0.054 0.054 0.055 0.054 0.054 0.052 0.052 0.052 0.052 0.052 0.051 0.050 0.050 0.050 0.047 0.047 0.050 0.052 0.054 0.055 0.054 0.052 0.052, mean 0.052, deviation from mean 0.002
4. G32 bed probe heights: 0.043 0.045 0.046 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.049 0.047 0.047 0.050 0.047 0.050 0.052 0.052 0.052 0.052 0.052 0.052 0.052, mean 0.049, deviation from mean 0.003
5. G32 bed probe heights: 0.041 0.043 0.045 0.045 0.045 0.045 0.045 0.045 0.045 0.046 0.045 0.049 0.050 0.052 0.052 0.052 0.050 0.050 0.050 0.050 0.050 0.050 0.050 0.050, mean 0.048, deviation from mean 0.003

## 5 mm/s (6):
1. G32 bed probe heights: 0.083 0.083 0.087 0.087 0.087 0.087 0.093 0.093 0.093 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.087 0.085, mean 0.088, deviation from mean 0.002
2. G32 bed probe heights: 0.060 0.062 0.062 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.068 0.062 0.062 0.062 0.062 0.062 0.062 0.062, mean 0.065, deviation from mean 0.003
3. G32 bed probe heights: 0.050 0.052 0.058 0.058 0.058 0.058 0.058 0.058 0.058 0.058 0.058 0.058 0.052 0.058 0.052 0.052 0.052 0.052 0.052 0.052 0.052 0.052 0.052 0.052, mean 0.055, deviation from mean 0.003
4. G32 bed probe heights: 0.040 0.043 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047, mean 0.047, deviation from mean 0.002
5. G32 bed probe heights: 0.038 0.043 0.043 0.043 0.045 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.045 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047 0.047, mean 0.046, deviation from mean 0.002

# Notes/Observations

The M48 tests were done in sequence as the printer cooled down.
So, it seems deviation improves as the printer cools.
The hotend also cools faster than anything else.
Therefore, if deviation improves quickly it could mean the hotend being cool matters most.
After doing the 2 mm/s tests, I dont think the temperature is as important as I assumed at first.

Interestingly, 2 mm/s probing had consistently lower deviation and range than 1 mm/s for both probes.
This is great because 1 mm/s probes are quite noisy on my printer, and obviously slower.
What's even more interesting is that 5 mm/s had similar deviation and range performance. 2 mm/s is probably the safest bet, however.
This aligns closely with the euclid measurement data.

# Improvements
It would be nice to store all data in a CSV.
This should include chamber, bed, hotend temps, probe height, probe speed.
It might be possible to output this from a G-code macro.

This is a simulated random walk solver for the 2013 mystery hunt puzzle.
http://www.coinheist.com/oceans_11/random_walk/

All of the files are approximately the same algorithm, but are setup for increasingly difficult puzzles/sizes.
The recommended invocation (in the Julia Programming Language) is ```@everywhere begin if myid() != 1 reload("rw#.jl") end end```. I used 70 instances for the harder problems.
(rw.py was written first, but is approx 10x slower than the nearly identical transcription in rw.jl)

rw1 was a prototype test from the example. rw2 and rw3 typically find their solution very fast and fast, respectively (given enough processors).

rw4 did not find a solution in the ~12 hours I gave it to run. rw1-3 were faster by computer than by hand. however, rw4-5 were solved by-hand during the hunt in a few hours.

the final output from rw5.jl can be found in rw5.txt, as well as the (manually improved) log from top at the conclusion of the run (I only know it's finish time to within a few hours of it discovering a solution)



Since I didn't bother to comment the code, here a quick overview of the algorithm. From the current square, we first check if it is a valid location to be in (no constraints have been violated), then we recurse in all directions. The order of the recursion is picked randomly at each step, on each processor, for simple (naive) parallism. We raise an error, "Done()", to quickly (and cheaply) escape all of the recusion once we found the solution. Thus, the return value "false" is unnecessary and unused.

A location is valid if
 - we haven't arrived at a solution
 - we are still on the grid
 - we haven't visited the location before
 - we haven't already had too many tracks in the current row or column
 - we still possibly have a path back up/left (if it is needed) and to the bottom/right (the end)

The more complex grids have various cutouts in them. However, we note that there is never more than one in a given row or column, so we are able to simply represent these with a (transition point, new count) pair.



Specs of the primary test computer:
```
> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 47
model name      : Intel(R) Xeon(R) CPU E7- 8850  @ 2.00GHz
stepping        : 2
microcode       : 0x36
cpu MHz         : 1064.000
cache size      : 24576 KB
physical id     : 0
siblings        : 10
core id         : 0
cpu cores       : 10
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 11
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt aes lahf_lm ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips        : 4000.05
clflush size    : 64
cache_alignment : 64
address sizes   : 44 bits physical, 48 bits virtual
power management:

...
```
for a total of 80 processors (and 1TB of ram)

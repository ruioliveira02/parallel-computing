METRICS=instructions,cycles,L1-dcache-load-misses

make && sudo perf stat -r 20 -e $METRICS sh -c "make run > /dev/null"
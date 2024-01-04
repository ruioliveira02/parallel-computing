#!/bin/sh
compile_program() {
    make clean
    make "$@"
    if [ $? -eq 0 ]; then
        echo "Compilation successful!"
    else
        echo "Compilation failed."
        exit 1
    fi
}

# Function to run the compiled program X times with different arguments
run_program_multiple_times() {
    repetitions=$1

    for ((i=1; i<=repetitions; i++)); do
        echo "Running iteration $i"
        make run
        mv slurm*.out temp.txt

        real=$(tail -n 3 temp.txt | head -n 1 | awk '{print $2}' | sed -E 's/([0-9]+)m([0-9]+\.[0-9]+)s/\1\2/')
        user=$(tail -n 2 temp.txt | head -n 1 | awk '{print $2}' | sed -E 's/([0-9]+)m([0-9]+\.[0-9]+)s/\1\2/')
        sys=$(tail -n 1 temp.txt | head -n 1 | awk '{print $2}' | sed -E 's/([0-9]+)m([0-9]+\.[0-9]+)s/\1\2/')
        
        echo "$i;$2;$3;$4;$real;$user;$sys" >> results.csv

        rm temp.txt
    done

}

# List of possible values for each individual argument
n_values=("1000" "10000" "20000" "30000" "40000" "50000" "60000" "70000" "80000" "90000" "100000")
iteration_values=("200")
thread_values=("256")
# Add more values as needed

# Number of times to run the program for each set of arguments
repetitions_per_set=3

echo "Repetition;N;Iteration Count;Threads Per Block;Real Time; User Time; Sys Time" >  results.csv

# Loop through each combination of arguments
for arg1 in "${n_values[@]}"; do
    for arg2 in "${iteration_values[@]}"; do
        for arg3 in "${thread_values[@]}"; do
            # Add more nested loops for additional arguments

            # Assemble the current set of arguments
            arguments_set="N=$arg1 ITERATION_COUNT=$arg2 THREADS_PER_BLOCK=$arg3"

            # Add more variables for additional arguments
            echo "Compiling with arguments: $arguments_set"
        
            compile_program $arguments_set
       
            run_program_multiple_times $repetitions_per_set $arg1 $arg2 $arg3
        done
    done
done
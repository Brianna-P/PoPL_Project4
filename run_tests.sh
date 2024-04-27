
passed_tests=0
total_tests=0

total_tests=$(ls -1 *.smp 2>/dev/null | wc -l)

if [ $total_tests -eq 0 ]; then
    echo "No test files found."
    exit 1
fi

for input_file in *.smp; do
    base_name=$(basename "$input_file" .smp)
    
    ./simple.exe < "$input_file" > "$base_name.tmp"

    diff -q "$base_name.tmp" "$base_name.smp.out" > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "Test $base_name: PASSED"
        ((passed_tests++))
    else
        echo "Test $base_name: FAILED"
    fi

    rm "$base_name.tmp"
done

echo "Total passed tests: $passed_tests out of $total_tests"

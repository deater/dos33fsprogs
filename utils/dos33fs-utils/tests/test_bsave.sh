echo "Testing dos33 BSAVE"

fail() {
    echo "$1" >&2
    num_failed=$(($num_failed + 1))
}
num_failed=0

tempfile=$(mktemp -t temp.XXXXXXXXXX)
run_test() {
    cmd_args=$1
    shift
    expect_strings="$@"
    # run and assert return code is zero
    ../dos33 -d ./test.dsk $cmd_args >"$tempfile" 2>&1 || fail "Command failed: $(cat "$tempfile")"
    # assert all expected strings are present in output
    for expect_str in $expect_strings
    do
        grep "$expect_str" "$tempfile" >/dev/null || fail "Command output missing expected string, '$expect_str'"
    done
}

cp empty.dsk test.dsk
run_test "BSAVE SINCOS" \
         "type=b" "Local filename: SINCOS" "Apple filename: SINCOS"
run_test "BSAVE SINCOS EX1" \
         "type=b" "Local filename: SINCOS" "Apple filename: EX1"
run_test "BSAVE -a 0x2000 SINCOS EX2" \
         "type=b" "Local filename: SINCOS" "Apple filename: EX2" "Address=8192"
run_test "BSAVE -a 0x2000 -l 146 SINCOS EX3" \
         "type=b" "Local filename: SINCOS" "Apple filename: EX3" "Address=8192" "Length=146"
rm "$tempfile"
if [ "$num_failed" -gt 0 ]; then
    echo "Test failed. $num_failed tests failed."
    exit 1
fi
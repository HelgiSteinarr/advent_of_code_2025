
package no3

import "core:testing"

@(test)
test_1 :: proc(t: ^testing.T) {
    testing.expect_value(t, part1("input.txt"), 17412)
    testing.expect_value(t, part1("input_example.txt"), 357)
}

test_2 :: proc(t: ^testing.T) {
    testing.expect_value(t, part2("input.txt"), 172681562473501)
    testing.expect_value(t, part2("input_example.txt"), 3121910778619)
}
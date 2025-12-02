package no1_1 

import "core:testing"

@(test)
test_1 :: proc(t: ^testing.T) {
    testing.expect_value(t, no1("input.txt"), 962)
    testing.expect_value(t, no1("input_example.txt"), 3)
}

@(test)
test_2 :: proc(t: ^testing.T) {
    testing.expect_value(t, no1("input.txt", part2=true), 5781)
    testing.expect_value(t, no1("input_example.txt", part2=true), 6)
}
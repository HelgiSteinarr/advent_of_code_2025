
package no2

import "core:testing"

@(test)
test_1 :: proc(t: ^testing.T) {
    testing.expect_value(t, no2("input.txt"), 43952536386)
    testing.expect_value(t, no2("input_example.txt"), 1227775554)
}
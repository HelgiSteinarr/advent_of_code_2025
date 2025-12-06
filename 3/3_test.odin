
package no3

import "core:testing"

@(test)
test_1 :: proc(t: ^testing.T) {
    testing.expect_value(t, no3("input.txt"), 17412)
    testing.expect_value(t, no3("input_example.txt"), 357)
}
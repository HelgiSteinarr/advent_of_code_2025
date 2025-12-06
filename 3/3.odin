package no3

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

main :: proc() {
	no3("input.txt")
}

Battery :: struct {
	high: int,
	lower: int
}

no3 :: proc(filename: string) -> int {
	data, ok := os.read_entire_file(fmt.tprintf("3/%s", filename), context.temp_allocator)
    if !ok do return fmt.println("failed to read file")

	total := 0

	for bank in strings.split(string(data), "\n", context.temp_allocator) {
		batt := Battery{
			high = 0,
			lower = 0,
			third = 0
		}
		for btry, index in bank {
			num, _ := strconv.digit_to_int(btry)
			if num > batt.high && index != len(bank) - 2 {
				batt.high = num 
				batt.lower = 0
			} else if num > batt.lower do batt.lower = num 

		}

		buf: [4]byte
		buf2: [4]byte
		high := strconv.write_int(buf[:], i64(batt.high), 10)
		second := strconv.write_int(buf2[:], i64(batt.lower), 10)

		jolts_int, _ := strconv.parse_int(fmt.tprintf("%s%s", high, second))
		total += jolts_int
	}
	fmt.println(total)
	return total
}

part2 :: proc(data: []byte) {
	for bank in strings.split(string(data), "\n", context.temp_allocator) {

	}
}

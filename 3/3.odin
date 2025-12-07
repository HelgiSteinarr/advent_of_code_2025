package no3

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

main :: proc() {
	fmt.println(part1("input.txt"))
	fmt.println(part2("input.txt"))
}

Battery :: struct {
	high: int,
	lower: int
}

part1 :: proc(filename: string) -> int {
	data, ok := os.read_entire_file(fmt.tprintf("3/%s", filename), context.temp_allocator)
    if !ok do return fmt.println("failed to read file")

	total := 0

	for bank in strings.split(string(data), "\n", context.temp_allocator) {
		batt := Battery{
			high = 0,
			lower = 0,
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
	return total
}

part2 :: proc(filename: string) -> int {
	data, ok := os.read_entire_file(fmt.tprintf("3/%s", filename), context.temp_allocator)
    if !ok do return fmt.println("failed to read file")
	total := 0

	for bank in strings.split(string(data), "\n", context.temp_allocator) {
		batt := [12]int{0,0,0,0,0,0,0,0,0,0,0,0}

		for btry, index_in_line in bank {
			num_in_line, _ := strconv.digit_to_int(btry)
			for num_in_batt, index_in_batt in batt {
				if num_in_line > num_in_batt && index_in_line < len(bank) - (len(batt) - index_in_batt) + 1 {
					batt[index_in_batt] = num_in_line
					clear_rest(&batt, index_in_batt)
					break
				}
			}
		}
		fmt.println(batt)

		// convert to whole number
		bank_total := 0
		for num in batt do inner_total = bank_total * 10 + num
		// for num, i in batt do total += num * pow_int(10, (len(batt) - i - 1))
		total += inner_total
	}
	return total
}

clear_rest :: proc(arr: ^[12]int, i: int) {
	for j := i + 1; j < len(arr^); j += 1 do arr^[j] = 0
}

pow_int :: proc(base, exp: int) -> int {
    result := 1
    for i in 0..<exp {
        result *= base
    }
    return result
}
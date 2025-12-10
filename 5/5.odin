package no5

import "core:strings"
import "core:os"
import "core:strconv"
import "core:fmt"
import "core:sort"


main :: proc() {
	part1("input.txt")
}

// 520
part1 :: proc(filename: string) -> int{
	data, ok := os.read_entire_file(fmt.tprintf("5/%s", filename), context.temp_allocator)
    if !ok do return fmt.println("failed to read file")

	ranges: [dynamic][2]int
	total := 0

	range_part := true
	for line in strings.split(string(data), "\n", context.temp_allocator) {
		line_split := strings.split(line, "-")
		if range_part && len(line_split) == 1 { 
			range_part = false
			continue
		}
		if range_part {
			lo, _ := strconv.parse_int(line_split[0])
			hi, _ := strconv.parse_int(line_split[1])
			range := [2]int{lo, hi}
			append(&ranges, range)
			continue
		}else {
			if is_fresh(line, ranges) do total += 1

		}

	}

	fmt.println(total)
	fmt.println(part2(ranges))
	return total
}

// 347338785050515
part2 :: proc(ranges: [dynamic][2]int) -> int{
	merged := merge(ranges)
	total := 0
	for range in merged do total += range[1] - range[0] + 1
	return total
}

is_fresh :: proc(line: string, ranges: [dynamic][2]int) -> bool {
	id, _ := strconv.parse_int(line)
	for range in ranges do if range[0] <= id && id <= range[1] do return true
	return false
}

merge :: proc(ranges: [dynamic][2]int) -> [dynamic][2]int{
	sort.quick_sort_proc(ranges[:], proc(a, b: [2]int) -> int {
		if a[0] < b[0] do return -1
		if a[0] > b[0] do return 1
		return 0
	})
	merged := [dynamic][2]int{}
	for range in ranges {
		if len(merged) == 0 {
			append(&merged, range)
			continue 
		}
		last := &merged[len(merged)-1]
		if range[0] <= last[1] + 1 do last[1] = max(last[1], range[1])
		else do append(&merged, range)
	}
	return merged
}
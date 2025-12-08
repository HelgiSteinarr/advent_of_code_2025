package no5

import "core:strings"
import "core:os"
import "core:strconv"
import "core:fmt"

main :: proc() {
	part1_ver2("input.txt")
}

part1 :: proc(filename: string) -> int{
	data, ok := os.read_entire_file(fmt.tprintf("5/%s", filename), context.temp_allocator)
    if !ok do return fmt.println("failed to read file")

	ranges: [dynamic]string
	total := 0

	range_part := true
	for line in strings.split(string(data), "\n", context.temp_allocator) {
		line_split := strings.split(line, "-")
		if range_part && len(line_split) == 1 { 
			range_part = false
			continue
		}
		if range_part {
			fmt.println("range part if")
			append(&ranges, line)
			continue
		}

		if is_fresh(line, &ranges) do total += 1
	}
	fmt.println(total)
	return total
}

// PLAN FOR TOMORROW (solve this faster, so the code actually finishes to run)
// ranges [[3,5][10,14][16,20]]
// points [1,5,8,11,17,32]
// convert points to [[p,p] for p in points]
// intervals = ranges + points
// merged = []
// for (a,b) in intervals-sorted
//	if merged empty do append [a,b]
//  else
//  	ax bx = merged[-2:]
//		if a <= bx + 1 - touching 
// 			merged[-2:] = [ax, max(bx, b)]
//      else
//          merged append [a,b]
//
// spoiled = []
// for i in 0..len merged -2
// 	last end = merged[i][-1]
//  next start = merged[i+1][0]
//  if last end + 1 <= next start -1
//	   append spoiled [last end + 1, next start -1]




// str_to_arr :: proc(str: []string) -> [dynamic]int {
// 	low, _ := strconv.parse_int(str[0], 10)
// 	high, _ := strconv.parse_int(str[1], 10)
// 	arr: [dynamic]int
// 	for ; low <= high; low += 1 {
// 		append(&arr, low)
// 	} 
// 	return arr
// }

is_fresh :: proc(id: string, ranges: ^[dynamic]string) -> bool {
	id_int, _ := strconv.parse_int(id, 10)
	for range in ranges^{
		range_split := strings.split(range, "-")
		low, _ := strconv.parse_int(range_split[0], 10)
		high, _ := strconv.parse_int(range_split[1], 10)
		for ; low <= high; low += 1 {
			if id_int == low do return true
		}
	}
	return false
}
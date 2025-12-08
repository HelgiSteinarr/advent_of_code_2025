package no4

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:os"

main :: proc() {
	fmt.println(run("input.txt"))
}

run :: proc(filename: string) -> (int, int) {
	data, ok := os.read_entire_file(fmt.tprintf("4/%s", filename), context.temp_allocator)
    if !ok do return fmt.println("failed to read file"), 0

	// p1 := part1(data)
	p1 := 0
	p2 := part2(data)

	fmt.println(p2)

	return p1, p2 
}

part1 :: proc(data: []byte) -> int {
	total := 0

	grid := strings.split(string(data), "\n", context.temp_allocator)
	grid_copy := [dynamic]string{}

	for line, line_index in grid {
		append(&grid_copy, line)
		for item, roll_index in line {
			if item != '@' do continue

			before := ""
			after := ""
			if (line_index - 1 >= 0) do before = grid[line_index - 1][max(roll_index - 1, 0):min(roll_index + 2, len(line) - 1)]
			curr := line[max(roll_index - 1, 0):min(roll_index + 2, len(line) - 1)]
			if (line_index + 1 <= len(grid) - 1) do after = grid[line_index + 1][max(roll_index - 1, 0):min(roll_index + 2, len(line) - 1)]

			amount := cnt(before, "@") + cnt(curr, "@") + cnt(after, "@") - 1
			if amount < 4 {
				grid_copy[line_index] = fmt.tprintf("%s%s%s", grid_copy[line_index][:roll_index], "x", grid_copy[line_index][min(roll_index + 1, len(line) - 1):])
				total += 1
			}
		}
	}
	return total
}


part2 :: proc(data: []byte) -> int {
	total := 0
	prev_total := -1

	grid := strings.split(string(data), "\n", context.temp_allocator)

	grid_copy := [dynamic]string{}
	grid_copy2 := [dynamic]string{}

	for line in grid {
		append(&grid_copy, line)
		append(&grid_copy2, line)
	}

	compute(&grid_copy, &grid_copy2, &total, &prev_total)

	return total
}


cnt :: proc(s: string, el: string) -> int {
	return strings.count(s, el)
}

// part 1 output 1367

compute :: proc(grid1: ^[dynamic]string, grid2: ^[dynamic]string, total: ^int, prev_total: ^int) {
	if (total^ == prev_total^) do return
	else do prev_total^ = total^

	for line, line_index in grid1^ {
		for item, roll_index in line {
			if item != '@' do continue

			before := ""
			after := ""

			if (line_index - 1 >= 0) do before = grid1^[line_index - 1][max(roll_index - 1, 0):min(roll_index + 2, len(line) - 1)]
			curr := line[max(roll_index - 1, 0):min(roll_index + 2, len(line) - 1)]
			if (line_index + 1 <= len(grid1^) - 1) do after = grid1^[line_index + 1][max(roll_index - 1, 0):min(roll_index + 2, len(line) - 1)]

			amount := cnt(before, "@") + cnt(curr, "@") + cnt(after, "@") - 1
			if amount < 4 {
				grid2^[line_index] = fmt.tprintf("%s%s%s", grid2^[line_index][:roll_index], "x", grid2^[line_index][roll_index + 1:])
				total^ += 1
			}
		}
	}
	grid1^ = grid2^

	print_grid(grid2^)

	compute(grid2, grid1, total, prev_total)
}

// part2 output 9144

print_grid :: proc(grid: [dynamic]string) {
	fmt.println()
	for line in grid {
		fmt.println(line)
	}
}
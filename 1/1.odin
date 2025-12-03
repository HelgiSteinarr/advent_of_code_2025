package no1

import "core:os"
import "core:fmt"
import "core:strings"
import "core:math"
import "core:strconv"

import logger "../utils" 


main :: proc() {
    file := "input.txt"
    n2 := false
    if len(os.args) > 1 {
        for a in os.args {
            if a == "x" do file = "input_example.txt"
            if a == "2" do n2 = true
        }
    }
    no1(file, part2=n2)
}

no1 :: proc(filename: string, part2: bool = false) -> int{
    data, ok := os.read_entire_file(fmt.tprintf("1/%s", filename), context.temp_allocator);
    if !ok do return fmt.println("failed to read file");
    
    fmt.println(part2)

    l := logger.init()
    defer logger.destroy(&l)

    // 0 - 1 2 3 4 5 6 7 8 9 - 0
    ptr := 50
    count := 0
    for line in strings.split(string(data), "\n", context.temp_allocator) {
        if len(line) == 0 do continue
        num, _ := strconv.parse_int(line[1:], 10)

        // for part 2
        rounds := num / 100
        prev_ptr := ptr

        num = num % 100
        switch letter := line[0]; letter {
        case 76: // [L]eft (subtract)
            if num > ptr do ptr = 100 - math.abs(ptr - num)
            else do ptr -= num
        case 82: // [R]ight (add) 
            if ptr + num > 100 do ptr = num - (100 - ptr) 
            else do ptr += num
        case: return fmt.println("didnt read L or R at start of line")
        }
        if ptr == 0 || ptr == 100 do count += 1

        // For part 2: count roundtrips and also stray roundovers except when starting at either extreme.
        if part2 do count += rounds
        if part2 && line[0] == 76 && num > prev_ptr && prev_ptr != 0 do count += 1
        if part2 && line[0] == 82 && num + prev_ptr > 100 && prev_ptr != 100 do count += 1

        numasu8: [32]u8
        strconv.write_int(numasu8[:], i64(ptr), 10)
        logger.log(&l, line, " ", string(numasu8[:]), " | ")
    }

    logger.print(&l)
    fmt.println(count)
    return count
}

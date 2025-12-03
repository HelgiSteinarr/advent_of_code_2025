package no2

import "core:strings"
import "core:os"
import "core:fmt"
import "core:mem"
import "core:strconv"

main :: proc() {
    no2("input.txt")
}

no2 :: proc(filename: string) -> int{
    data, ok := os.read_entire_file(fmt.tprintf("2/%s", filename), context.temp_allocator)
    if !ok do return fmt.println("failed to read file")

    split := strings.split(string(data), ",")
    defer delete(split)

    // custom allocator for fun to use and destroy for the iteration split
    arena: mem.Arena
    arena_mem := make([]byte, 1 * mem.Kilobyte, context.allocator)
    mem.arena_init(&arena, arena_mem)
    defer delete(arena_mem)

    total := 0
    alloc := mem.arena_allocator(&arena)
    for range in split {
        range := strings.split(range, "-", allocator=alloc)
        
        lo, _ := strconv.parse_int(range[0], 10)
        hi, _ := strconv.parse_int(range[1], 10)
        for num := lo; num <= hi; num += 1 {
            buf: [32]u8
            str := strconv.write_int(buf[:], i64(num), 10)

            if len(str) % 2 != 0 do continue
            if str[:len(str)/2] == str[len(str)/2:] do total += num
        }

        free_all(alloc)
    }
    fmt.println(total)
    return total
}

// split_and_check :: proc(str: string) -> bool{
//     if len(str) % 2 != 0 {
//         if len(str) == 1 do return false 
//         return
//     }
//     if str[:len(str)/2] == str[len(str)/2:] do return true
//     return split_and_check(str[:len(str)/2]) & split_and_check(str[len(str)/2:])
// }
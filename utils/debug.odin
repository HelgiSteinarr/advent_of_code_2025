package logger 

import "core:strings"
import "core:fmt"

init :: proc(alloc := context.allocator) -> strings.Builder {
    sb: strings.Builder;
    strings.builder_init(&sb, alloc);
    return sb
}

destroy :: proc(sb: ^strings.Builder) {
    strings.builder_destroy(sb)
}

log :: proc(sb: ^strings.Builder, parts: ..string) {
    for part in parts do strings.write_string(sb, part)
}

print :: proc(sb: ^strings.Builder) {
    fmt.println(strings.to_string(sb^))
}
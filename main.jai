#import "Basic";
#import "Command_Line";

is_leap_year :: (year: int) -> bool {
    return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0);
}

weekday :: (year: int, month: int, day: int) -> int {
    offsets := int.[0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];

    if month < 3 {
        year -= 1;
    }

    return (year + year / 4 - year / 100 + year / 400 + offsets[month - 1] + day) % 7;
}

friday_the_13ths :: (year: int) -> int {
    count := 0;

    for month: 1..12 {
        if weekday(year, month, 13) == 5 {
            count += 1;
        }
    }

    return count;
}

main :: () {
    args := get_command_line_arguments();
    defer array_reset(*args);

    if args.count != 2 {
        print("\x1b[31;1merror:\x1b[0m invalid arguments.\n");
        print("usage: % <year>\n", args[0]);
        exit(1);
    }

    year, ok := string_to_int(args[1]);

    if !ok {
        print("\x1b[31;1merror:\x1b[0m invalid year.\n");
        print("usage: % <year>\n", args[0]);
        exit(1);
    }

    print("The year % has % Friday the 13ths\n", year, friday_the_13ths(year));
}

// Day 2: Bathroom Security
module day2 =
    type Instruction =
        | U
        | L
        | R
        | D

    type Coord = { X: int; Y: int}

    let keypad = [ 
        [ 1; 2; 3];
        [ 4; 5; 6];
        [ 7; 8; 9];
        ]

    let safe =
        function
        | x when x < 0 -> 0
        | x when x > 2 -> 2
        | x -> x

    let motion loc =
        function
        | Some U -> {loc with Y = loc.Y - 1 |> safe}
        | Some L -> {loc with X = loc.X - 1 |> safe}
        | Some R -> {loc with X = loc.X + 1 |> safe}
        | Some D -> {loc with Y = loc.Y + 1 |> safe}
        | None -> {X = 999; Y = 999}

    let parse =
        function
        | 'U' -> Some U
        | 'L' -> Some L
        | 'R' -> Some R
        | 'D' -> Some D
        | _ -> None

    let key loc = keypad.[loc.Y].[loc.X]
                    
    let keypad2 = [
        [ 0; 0; 1; 0; 0]; 
        [ 0; 2; 3; 4; 0]; 
        [ 5; 6; 7; 8; 9]; 
        [ 0; 10; 11; 12; 0]; 
        [ 0; 0; 13; 0; 0]; 
        ]

    let key2 loc = keypad2.[loc.Y].[loc.X]

    let safe2 =
        function
        | x when x < 0 -> 0
        | x when x > 4 -> 4
        | x -> x

    let motion2 loc i =
        let newLoc = i |> (fun i -> match i with 
                                    | Some U -> {loc with Y = loc.Y - 1 |> safe2}
                                    | Some L -> {loc with X = loc.X - 1 |> safe2}
                                    | Some R -> {loc with X = loc.X + 1 |> safe2}
                                    | Some D -> {loc with Y = loc.Y + 1 |> safe2}
                                    | None -> {X = 999; Y = 999})
        if key2 newLoc = 0
        then loc
        else newLoc

    let contents = System.IO.File.ReadAllText(__SOURCE_DIRECTORY__ + "/day2.txt")
    let commands = contents.Split([|"\r\n"; "\n"|], System.StringSplitOptions.RemoveEmptyEntries) |> Seq.map (Seq.map parse)

    // part 1
    let start = {X = 1; Y = 1}
    let locations = Seq.scan (Seq.fold motion) start commands
    // skip the first digit, since it's the start point
    let digits = Seq.map key locations |> Seq.map (sprintf "%X") |> Seq.tail |> String.concat ""
    printfn "day2: %A" digits

    // part 2
    let start2 = {X = 0; Y = 2}
    let locations2 = Seq.scan (Seq.fold motion2) start2 commands
    let digits2 = Seq.map key2 locations2 |> Seq.map (sprintf "%X") |> Seq.tail |> String.concat ""
    printfn "day2': %A" digits2
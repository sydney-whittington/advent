// Day 1: No Time for a Taxicab
module Day1 =
    type Facing =
        | North
        | East
        | South
        | West

    let leftTurn =
        function
        | North -> West
        | West -> South
        | South -> East
        | East -> North

    let rightTurn =
        function
        | North -> East
        | West -> North
        | South -> West
        | East -> South

    type Direction =
        | L of int
        | R of int

    type Coordinate = { X: int; Y: int}
    type Position = {Facing: Facing; Coords: Coordinate}

    // calculate the new XY coordinates from a facing and distance
    let step facing distance coordinate =
        match facing with
        | North -> 
            {X = coordinate.X; 
             Y = coordinate.Y + distance}
        | West -> 
            {X = coordinate.X - distance; 
             Y = coordinate.Y}
        | South -> 
            {X = coordinate.X; 
             Y = coordinate.Y - distance}
        | East -> 
            {X = coordinate.X + distance; 
             Y = coordinate.Y}

    // move following the specified direction
    let move position =
        function
        | L x -> 
            let newFace = leftTurn position.Facing
            {Facing = newFace; Coords = step newFace x position.Coords}
        | R x -> 
            let newFace = rightTurn position.Facing
            {Facing = newFace; Coords = step newFace x position.Coords}

    // active pattern for checking prefix on string
    let (|Prefix|_|) (p:string) (s:string) =
        if s.StartsWith(p) then
            Some(s.Substring(p.Length))
        else
            None

    // return Some Direction from a string
    let parse =
        function
        | Prefix "L" rest -> int rest |> L |> Some
        | Prefix "R" rest -> int rest |> R |> Some
        | _ -> None

    let nextStep position command =
        match parse command with
        | Some d -> move position d
        | None -> move position (L 0)

    let interpolateX (first:Position) (last:Position) =
        let cons = (fun x -> {Facing = first.Facing; Coords = {X = x; Y = first.Coords.Y}})
        if first.Coords.X < last.Coords.X
        then List.map cons [first.Coords.X .. last.Coords.X-1] 
        else List.map cons [first.Coords.X .. -1 .. last.Coords.X+1] 

    let interpolateY (first:Position) (last:Position) =
        let cons = (fun y -> {Facing = first.Facing; Coords = {X = first.Coords.X; Y = y}})
        if first.Coords.Y < last.Coords.Y
        then List.map cons [first.Coords.Y .. last.Coords.Y-1] 
        else List.map cons [first.Coords.Y .. -1 .. last.Coords.Y+1] 

    // add implicit locations
    let rec missing =
        function
        | [] -> []
        | step::[] -> [step]
        | step::next::rest ->
            let notStep = next::rest
            if step.Coords.X <> next.Coords.X
            then List.concat [interpolateX step next; missing notStep]
            else List.concat [interpolateY step next; missing notStep]

    // find first duplicate
    let rec hq positions (visited:Set<Coordinate>) =
        match positions with
        | [] -> {X = 999; Y = 999}
        | position::rest ->
            let coord = position.Coords
            if visited.Contains coord 
            then coord
            else hq rest (visited.Add coord)

    // part 1
    let contents = System.IO.File.ReadAllText(@"../../day1.txt")
    // split on comma space, and on newline for the last entry
    let commands = contents.Split([|", ";"\n"|], System.StringSplitOptions.RemoveEmptyEntries)

    let start = {Facing = North; Coords = {X = 0; Y = 0}}
    let finish = Seq.fold nextStep start commands
    let day1 = abs finish.Coords.X + abs finish.Coords.Y
    printfn "day1: %d" day1

    // part 2
    // build up intermediate steps
    let steps = Seq.scan nextStep start commands

    let allSteps = missing (Seq.toList steps)
    let hqLocation = hq (Seq.toList allSteps) Set.empty
    let day1' = abs hqLocation.X + abs hqLocation.Y
    printfn ("day1': %A") day1'


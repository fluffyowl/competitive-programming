open System;

let input:String array=Console.ReadLine().Split(' ')
let N = int(input.[0])
let K = int(input.[1])
let Q = int(input.[2])

let mutable row = [for i in 0..N-1 -> (0, i)] |> Seq.toArray
let mutable col = [for i in N..N+N-1 -> (0, i)] |> Seq.toArray
let mutable colors = [for i in 1..K -> 0L] |> Seq.toArray

let rec binsearch (arr: (int * int)[], hi: int, lo: int, v: int) =
    if hi - lo <= 1 then lo
    elif snd arr.[(hi+lo)/2] < v then binsearch(arr, hi, (hi+lo)/2, v)
    else binsearch(arr, (hi+lo)/2, lo, v)

for i in N+N..N+N+Q-1 do 
    let s:String array=Console.ReadLine().Split(' ')
    let A = s.[0]
    let B = int(s.[1]) - 1
    let C = int(s.[2]) - 1
    if A = "R" then row.[B] <- (C, i) else col.[B] <- (C, i)


row <- Array.sortBy(fun (_, y) -> y) row
col <- Array.sortBy(fun (_, y) -> y) col

for i in 0..N-1 do
    colors.[fst row.[i]] <- colors.[fst row.[i]] + int64(binsearch(col, N, -1, snd row.[i]) + 1)

for i in 0..N-1 do
    colors.[fst col.[i]] <- colors.[fst col.[i]] + int64(binsearch(row, N, -1, snd col.[i]) + 1)

for i in 0..K-1 do
    Console.WriteLine(colors.[i])

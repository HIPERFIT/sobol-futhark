fun qq s = "'" ^ s ^ "'"
fun println s = print (s ^ "\n")

fun die s =
    (println ("Error: " ^ s);
     OS.Process.exit ~1)

type num = string
type line = {d:num,s:num,a:num,m:num list}

fun parseLine s : line =
    let val ns = String.tokens Char.isSpace s
    in case ns of
           d :: s :: a :: m => {d=d,s=s,a=a,m=m}
         | _ => die ("expecting at-least 3 numbers on each line: line is " ^ qq s)
    end

val s = TextIO.inputAll TextIO.stdIn
val lines = String.tokens (fn c => c = #"\n") s

fun pad_ns n (x::xs) = x :: pad_ns (n-1) xs
  | pad_ns n nil = if n <= 0 then nil
                   else "0" :: pad_ns (n-1) nil

fun max n (x::xs) = if x > n then max x xs else max n xs
  | max n nil = n

fun ppNum n = n ^ "u32"
fun ppInt n = n ^ "i32"

fun ppNumLine xs = "[" ^ String.concatWith ", " (List.map ppNum xs) ^ "]"

val () = case lines of
             _ :: lines =>
             let val ls = List.map parseLine lines
                 val ls = List.take (ls, 50)
                 val N = length ls
                 val sz = max 0 (List.map (length o #m) ls)
                 val ls = List.map (fn {d,s,a,m} => {d=d,s=s,a=a,m=pad_ns sz m}) ls
                 val m = "[" ^ String.concatWith ",\n     " (List.map (ppNumLine o #m) ls) ^ "]"
                 val a = "[" ^ String.concatWith ",\n     " (List.map (ppNum o #a) ls) ^ "]"
                 val d = "[" ^ String.concatWith ",\n     " (List.map (ppNum o #d) ls) ^ "]"
                 val s = "[" ^ String.concatWith ",\n     " (List.map (ppInt o #s) ls) ^ "]"
             in println "module sobol_dir : {"
              ; println "  val m : [][]u32"
              ; println "  val a : []u32"
              ; println "  val s : []i32"
(*              ; println "  val d : []u32" *)
              ; println "} = {"
              ; println("  let m : [" ^ Int.toString N ^ "][" ^ Int.toString sz ^ "]u32 = \n    " ^ m)
              ; println("  let a : [" ^ Int.toString N ^ "]u32 = \n    " ^ a)
              ; println("  let s : [" ^ Int.toString N ^ "]i32 = \n    " ^ s)
(*              ; println("  let d : [" ^ Int.toString N ^ "]u32 = \n    " ^ d) *)
              ; println "}"
             end
           | _ => die "expecting at-least one line"

_first = -> x { x[0] }
_split = -> x, y { y.split(x) }.curry(2)
send_reducer = -> y, lamb { lamb.call(y) }
pipe = -> *lambs { -> x { lambs.reduce(x, &send_reducer) } }
is_alt = -> attr { attr.include?('alt=') }
find_alt = -> els { els.find(&is_alt) }
get_alt = -> attr { attr.split('=').last.slice(1...-1) }
alt_pipe = pipe.call(_first, _split.call(' '), find_alt, get_alt, -> alt { "### #{alt}" }, -> x { [x] })

puts "Please paste youre string of screenshot tags\n"
input = gets("\n\n").chomp
puts input.
  split("\n").
  each_slice(2).
  map { |pair| alt_pipe.call(pair).concat(pair).join("\n") }.
  join("\n\n")

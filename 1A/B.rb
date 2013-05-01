require 'pp'

def ppd(*arg)
  if $DEBUG
    pp(*arg)
  end
end

def putsd(*arg)
  if $DEBUG
    puts(*arg)
  end
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  for i in 1 .. count
    words << readline.chomp
  end
  words
end

$max_gain = 0
def solve(acts, n, energy, max_energy, gain, regain)
  if acts.size == n
    if gain > $max_gain
      $max_gain = gain
    end
    return
  end

  for i in 0..energy
    current_e = energy-i+regain
    if current_e > max_energy
      current_e = max_energy
    end
    solve(acts, n+1, current_e, max_energy, gain+acts[n]*i, regain)
  end
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  e, r, n = ris
  acts = ris
  raise if acts.size != n

  $max_gain = 0
  solve(acts, 0, e, e, 0, r)

  puts "Case ##{case_index}: #{$max_gain}"

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end

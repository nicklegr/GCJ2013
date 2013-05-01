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

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  r, t = ris

  # binary search
  upper = 2 * (10 ** 18)
  lower = 0

  while lower+1 < upper
    n = (lower + upper) / 2
    sum = (2 * r * (n+1)) + ((n + 1) * (2*n + 1))
#puts "#{lower}, #{upper}, #{n}, #{sum}"
    if sum < t
      lower = n
    elsif t < sum
      upper = n - 1
    else
      lower = n
      break
    end
  end

  sumL = (2 * r * (lower+1)) + ((lower + 1) * (2*lower + 1))
  sumU = (2 * r * (upper+1)) + ((upper + 1) * (2*upper + 1))
#puts "----- #{lower}, #{upper}, #{sumL}, #{sumU}"

  if sumU <= t
    answer = upper + 1
  else
    answer = lower + 1
  end

  puts "Case ##{case_index}: #{answer}"

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

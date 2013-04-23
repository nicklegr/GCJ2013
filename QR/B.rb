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

def check(f, n, m)
  max = 0
  for i in 0..n-1
    for j in 0..m-1
      max = f[i][j] if max < f[i][j]
    end
  end

  for i in 0..n-1
    for j in 0..m-1
      c = f[i][j]
      if c < max
        ok1 = true
        for k in 0..m-1
          ok1 = false if f[i][k] > c
        end

        ok2 = true
        for k in 0..n-1
          ok2 = false if f[k][j] > c
        end

        return false if !ok1 && !ok2
      end
    end
  end

  true
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  n, m = ris

  f = Array.new(n){ Array.new(m) }
  for i in 0..n-1
    f[i] = ris
  end

  ret = check(f, n, m) ? 'YES' : 'NO'

  puts "Case ##{case_index}: #{ret}"

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

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

def cost(n, distance)
  # @todo formula
  total = 0
  c = n
  for i in 1..distance
    raise if c < 2
    total += c
    c -= 1
  end
  total
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  n, m = ris

  tbl = []
  m.times do
    tbl << ris
  end

  tbl.sort! do |a, b|
    if a[0] == b[0]
      (a[1] - a[0]) <=> (b[1] - b[0])
    else
      a[0] <=> b[0]
    end
  end

  lost = 0

  loop do
    best_pair = nil
    best_gain = 0

    for i in 0...m
      if tbl[i][2] != 0
        for j in i+1...m
          #pp i,j 
          if tbl[j][2] != 0 && tbl[j][0] <= tbl[i][1] && !(tbl[i][0] <= tbl[j][0] && tbl[j][1] <= tbl[i][1]) && !(tbl[j][0] <= tbl[i][0] && tbl[i][1] <= tbl[j][1])
            swap_count = tbl[i][2] < tbl[j][2] ? tbl[i][2] : tbl[j][2]

            org_cost = cost(n, tbl[i][1] - tbl[i][0]) + cost(n, tbl[j][1] - tbl[j][0])
            new_cost = cost(n, tbl[j][1] - tbl[i][0]) + cost(n, tbl[i][1] - tbl[j][0])

            raise if new_cost >= org_cost

            gain = (org_cost - new_cost) * swap_count

            if best_gain < gain
              best_pair = [i, j]
              best_gain = gain
            end
          end
        end
      end
    end

    if !best_pair
      break
    else
      # swap i and j
      best_i, best_j = best_pair
      swap_count = tbl[best_i][2] < tbl[best_j][2] ? tbl[best_i][2] : tbl[best_j][2]

      lost += best_gain

      tbl[best_i][2] -= swap_count
      tbl[best_j][2] -= swap_count
    end
  end

  puts "Case ##{case_index}: #{lost}"

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

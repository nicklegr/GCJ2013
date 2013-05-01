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
  r, n, m, k = ris
  prods = []

  for i in 0...r
    prods << ris
  end

  # {
  #   [2, 2, 2] => [ products ]
  # }
  tbl = {}

  range = (2..m).to_a
  range.repeated_combination(n).each do |nums|
    products = {}
    for i in 0..n
      nums.combination(i).each do |subset|
        products[subset.inject(1, :*)] = true
      end
    end
    tbl[nums.join('')] = products
  end

  puts "Case ##{case_index}:"

  for i in 0...r
    given = prods[i]
    work = tbl.dup

    given.each do |x|
      work.delete_if do |key, v|
        !v.key?(x)
      end
    end

    puts work.first[0]
  end

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

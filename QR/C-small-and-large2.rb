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

def arr_x
  ret = []

  (0..25).each do |e|
    all_zero = '0' * e
    ret << [ all_zero, all_zero ]

    # 1 times
    (0..all_zero.size-1).each do |i|
      s = all_zero.dup
      s[i] = '1'
      ret << [ s, s.reverse ]
    end

    # 2 times
    (0..all_zero.size-1).each do |i|
      (i+1..all_zero.size-1).each do |j|
        s = all_zero.dup
        s[i] = '1'
        s[j] = '1'
        ret << [ s, s.reverse ]
      end
    end

    # 3 times
    (0..all_zero.size-1).each do |i|
      (i+1..all_zero.size-1).each do |j|
        (j+1..all_zero.size-1).each do |k|
          s = all_zero.dup
          s[i] = '1'
          s[j] = '1'
          s[k] = '1'
          ret << [ s, s.reverse ]
        end
      end
    end
  end

  ret
end

def check(str, a, b, max_root_digits)
  return false if str.size > max_root_digits

  root = str.to_i
  x = root * root

  a <= x && x <= b && x.to_s == x.to_s.reverse
end

# main
t_start = Time.now

a_x = arr_x

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  a, b = ris

  max_root_digits = b.to_s.size / 2 + 1

  # see http://web.archive.org/web/20020614225321/http://www.geocities.com/williamrexmarshall/math/palsq.html
  count = 0

  # trivial
  [0, 1, 2, 3].each do |e|
    count += 1 if check(e.to_s, a, b, max_root_digits)
  end

  # binary root
  a_x.each do |x|
    str = '1' + x[0] + x[1] + '1'
    count += 1 if check(str, a, b, max_root_digits)
  end

  # ternary root A
  # (0..1).each do |y|
  #   a_x.each do |x|
  #     str = '1' + x + y.to_s + x.reverse + '1'
  #     count += 1 if check(str, a, b, max_root_digits)
  #   end
  # end
  a_x.each do |x|
    l = '1' + x[0]
    l1 = l + '0'
    l2 = l + '1'

    r = x[1] + '1'

    str = l1 + r
    count += 1 if check(str, a, b, max_root_digits)

    str = l2 + r
    count += 1 if check(str, a, b, max_root_digits)
  end

  # ternary root B
  (0..25).each do |len|
    xs = ('0' * len)
    str = '1' + xs + '2' + xs + '1'
    count += 1 if check(str, a, b, max_root_digits)

    (0..len-1).each do |i|
      xs_2 = xs.dup
      xs_2[i] = '1'
      str = '1' + xs_2 + '2' + xs_2.reverse + '1'
      count += 1 if check(str, a, b, max_root_digits)
    end
  end

  # even root A
  (0..51-2).each do |i|
    str = '2' + ('0' * i) + '2'
    count += 1 if check(str, a, b, max_root_digits)
  end

  # even root B
  (0..1).each do |x|
    (0..25).each do |i|
      str = '2' + ('0' * i) + x.to_s + ('0' * i) + '2'
      count += 1 if check(str, a, b, max_root_digits)
    end
  end

  puts "Case ##{case_index}: #{count}"

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

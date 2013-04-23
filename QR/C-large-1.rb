require 'pp'

input = ARGF.readlines

count = input.shift.to_i

(0...4).each do |i|
  output = input.shift(count/4)
  File.write("C-large-1-sub-#{i}.in", output.join(""))
end

(0...4).each do |i|
  system("ruby C-worker.rb #{i*(count/4)+1} #{(i+1)*(count/4)} < C-large-1-sub-#{i}.in > C-large-1-sub-#{i}.out &")
end

# after completed:
# $ cat C-large-1-sub-0.out C-large-1-sub-1.out C-large-1-sub-2.out C-large-1-sub-3.out > C-large-1.out

N, M = gets.split.map(&:to_i)
a = Array.new(N, 0)

for i in 0...M do
    b = gets.split.map(&:to_i)
    for j in 0...N do
        a[j] += b[j]
    end

    s = 0
    l = 0
    
    for r in 0...N do
        s += a[r]
        while l < r && s > 777 do
            s -= a[l]
            l += 1
        end
        if s == 777 then
            puts "YES"
            exit
        end
    end
end

puts "NO"

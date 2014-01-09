class Base66
    @converts = [
        "~", ".", "_", "-",
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
    ]

    def self.encode(number)
        four = three = two = one = 0
        num = number.to_i
        if num / 66**3 >= 1
            four = (num / 66**3).to_i
            num -= four * 66**3
        end
        if num / 66**2 >= 1
            three = (num / 66**2).to_i
            num -= three * 66**2
        end
        if num / 66**1 >= 1
            two = (num / 66**1).to_i
            num -= two * 66**1
        end
        if num / 66**0 >= 1
            one = (num / 66**0).to_i
        end
        @converts[four].to_s+@converts[three].to_s+@converts[two].to_s+@converts[one].to_s
    end
    def self.decode(base66)
        num = 0
        c = 0
        for i in 0..3 #range(3, -1, -1)
            i = 3 - i
            num += (66**c * getIndex(base66[i]))
            c += 1
        end

        num
    end

    private
        def self.getIndex(val)
            ret = "Error"
            for i in 0..65
                if @converts[i] == val
                    ret = i
                    break
                end
            end
            ret
        end

end
=begin
puts Base66.encode(543690)  #returns .sni
puts Base66.decode(".sni")  #returns 543690
=end
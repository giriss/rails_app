=begin
@xs = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
@pages = 1..3
@new = Array.new

@pages.each do |page|
	x = (page-1)*10
	arr = Array.new
	if page == @pages.end
		y = x - 1 + (@xs.length % 10)
		(x..y).each do |i|
			arr << @xs[i].to_s
		end
	else
		y = x + 9
		(x..y).each do |i|
			arr << @xs[i].to_s
		end
	end
	@new << arr
end
@val = """Ok
Not Ok
Then what"""
@urls = Array.new
@urls = @val.split("\n")
puts @urls.size

require 'uri'
@uri = URI.decode("http%3A%2F%2Flocalhost%3A3000%2Fu%2Ftools")
puts @uri

@x = "xxx"
puts @x << ".xxx"
puts @x.concat ".xxx"

require 'nokogiri'

@x = <<-EOS
<a href="xs">x</a>
<a href="ys">y</a>
<a href="zs">z</a>
EOS

html_doc = Nokogiri::HTML @x
@urls = Array.new
html_doc.css("a").each do |a|
	@urls << a["href"]
end

puts html_doc.at_css("a")["href"]

puts html_doc.to_s.split("<html><body>\n")[1].split("</body></html>")[0]
=end

puts "".nil?
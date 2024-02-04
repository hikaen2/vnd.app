require 'csv'
require 'nokogiri'

puts ['Date', 'Buy', 'Transfer', 'Sell'].to_csv

Dir.glob('htmls/*.html').sort.each do |f|
  doc = Nokogiri::HTML(IO.read(f))
  values = doc.at_css("td:contains('JPY')").parent.css('td').map(&:text).map(&:strip)
  puts [f[/\d{4}-\d{2}-\d{2}/], values[-3], values[-2], values[-1]].to_csv
end

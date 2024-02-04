require 'date'
require 'optparse'

URL = 'https://portal.vietcombank.com.vn/UserControls/TVPortal.TyGia/pListTyGia.aspx?isEn=True&BacrhID=1&txttungay='

dry_run = false
from = Date::today - 1
to = nil

opt = OptionParser.new
opt.on('--dry-run') {|v| dry_run = true }
opt.on('--from DATE') {|v| from = Date::parse(v) }
opt.on('--to DATE') {|v| to = Date::parse(v) }
opt.parse!(ARGV)

to = from if to == nil
printf("from %s to %s\n", from, to)

(from..to).each do |d|
  cmd = sprintf("wget -O htmls/%s.html '%s%s'", d.strftime('%F'), URL, d.strftime('%Y/%m/%d'))
  if dry_run
    puts cmd
  else
    sleep(1)
    system(cmd)
  end
end

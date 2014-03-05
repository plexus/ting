# -*- coding: utf-8 -*-

require 'csv'
require 'rspec/autorun'

# Describes a problem with CSV parsing on JRuby, see output at the bottom.
#
# Version:
#   jruby 1.7.2 (1.9.3p327) 2013-01-04 302c706 on Java HotSpot(TM) Server VM 1.7.0_15-b03 [linux-i386]
# Has since been fixed, verified with 1.7.11

describe "a problem with jruby?" do
  let(:csv_full_contents) {
'"zhuyin","wadegiles","mps2","yale","tongyong","hanyu","gwoyeu1","gwoyeu2","gwoyeu3","gwoyeu4"
"ㄚ","a","a","a","a","a","a","ar","aa","ah"
"ㄞ","ai","ai","ai","ai","ai","ai","air","ae","ay"
"ㄢ","an","an","an","an","an","an","arn","aan","ann"
"ㄤ","ang","ang","ang","ang","ang","ang","arng","aang","anq"
"ㄠ","ao","au","au","ao","ao","au","aur","ao","aw"
"ㄅㄚ","pa","ba","ba","ba","ba","ba","bar","baa","bah"
"ㄅㄞ","pai","bai","bai","bai","bai","bai","bair","bae","bay"
"ㄅㄢ","pan","ban","ban","ban","ban","ban","barn","baan","bann"
"ㄅㄤ","pang","bang","bang","bang","bang","bang","barng","baang","banq"
"ㄅㄠ","pao","bau","bau","bao","bao","bau","baur","bao","baw"
"ㄅㄟ","pei","bei","bei","bei","bei","bei","beir","beei","bey"
"ㄅㄣ","pen","ben","ben","ben","ben","ben","bern","been","benn"
"ㄅㄥ","peng","beng","beng","beng","beng","beng","berng","beeng","benq"
"ㄅㄧ","pi","bi","bi","bi","bi","bi","byi","bii","bih"
"ㄅㄧㄢ","pien","bian","byan","bian","bian","bian","byan","bean","biann"
"ㄅㄧㄠ","piao","biau","byau","biao","biao","biau","byau","beau","biaw"
"ㄅㄧㄝ","pieh","bie","bye","bie","bie","bie","bye","biee","bieh"
"ㄅㄧㄣ","pin","bin","bin","bin","bin","bin","byn","biin","binn"
"ㄅㄧㄥ","ping","bing","bing","bing","bing","bing","byng","biing","binq"'
}

  def lines(range)
    csv_full_contents.split("\n")[range].join("\n")
  end

  it "this actually does raise an exception, so this spec fails" do
    expect{ CSV.parse(csv_full_contents) }.to_not raise_exception
  end

  it "using the first 15 lines still works ok" do
    expect{ CSV.parse(lines(0..15))}.to_not raise_exception
  end

  it "from line 16 on there's a problem" do
    expect{ CSV.parse(lines(0..16))}.to_not raise_exception
  end

  it "but line 16 itself isn't the culprit" do
    expect{ CSV.parse(lines(3..18))}.to_not raise_exception
  end
end


#   1) a problem with jruby? this actually does raise an exception, so this spec fails
#      Failure/Error: expect{ CSV.parse(csv_full_contents) }.to_not raise_exception
#        expected no Exception, got #<ArgumentError: invalid byte sequence in UTF-8> with backtrace:
#          # ./spec/jruby_csv_spec.rb:38:in `(root)'
#          # ./spec/jruby_csv_spec.rb:38:in `(root)'
#      # ./spec/jruby_csv_spec.rb:38:in `(root)'

#   2) a problem with jruby? from line 16 on there's a problem
#      Failure/Error: expect{ CSV.parse(lines(0..16))}.to_not raise_exception
#        expected no Exception, got #<ArgumentError: invalid byte sequence in UTF-8> with backtrace:
#          # ./spec/jruby_csv_spec.rb:46:in `(root)'
#          # ./spec/jruby_csv_spec.rb:46:in `(root)'
#      # ./spec/jruby_csv_spec.rb:46:in `(root)'

# Finished in 0.111 seconds
# 4 examples, 2 failures

# Failed examples:

# rspec ./spec/jruby_csv_spec.rb:37 # a problem with jruby? this actually does raise an exception, so this spec fails
# rspec ./spec/jruby_csv_spec.rb:45 # a problem with jruby? from line 16 on there's a problem

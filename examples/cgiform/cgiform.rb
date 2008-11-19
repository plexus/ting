#!/usr/bin/ruby -w


require 'cgi'
require 'erb'

$: << File.dirname(__FILE__)+'/../../lib'
require 'pinyin'

cgi=CGI.new("xhtml1")

params=cgi.params
begin
  if params['pinyin'] && params['pinyin'] != '' && params['pinyin'] != []
    @converted = Pinyin::Writer.new(params['to'], params['to_tone']) << (Pinyin::Reader.new(params['from'],params['from_tone']) << params['pinyin'].first)
  end
rescue
  cgi.out{$!.to_s}
  cgi.out{params['pinyin'].inspect}
end

cgi.out("text/html; charset=utf-8") do
  ERB.new(IO.read('template.rhtml')).result(binding)
end

require 'csv'
require 'yaml'

module Ting
  module Conversions
    All=[]

    DATA_DIR=File.dirname(__FILE__)+'/data/'

    #Load various representations for initials and finals
    %w(Initial Final).each do |c|
      klazz=Ting.const_get c
      begin
        CSV.open(DATA_DIR+c.downcase+'.csv', 'r').each do |name, *values|
          All << name.to_s unless All.index name || name =~ /name|standalone/i
          klazz.class_eval {attr_accessor name.to_sym}
          values.each_with_index do |v,i|
            klazz::All[i].send(name+'=', v)
          end
        end
      rescue
        puts "Bad data in #{c.downcase}.csv : " + $!
        raise
      end
      
    end

    #Substitution rules 
    @@rules=YAML::load(IO.read(DATA_DIR+'rules.yaml'))

    def self.parse(type, string)
      if (fin = Final::All.find {|f| f.respond_to?("#{type}_standalone") && f.send("#{type}_standalone") == string})
        TonelessSyllable.new(Initial::Empty, fin)
      else
        Initial::All.find do |ini|
          Final::All.find do |fin|
            next                                  if TonelessSyllable.illegal?(ini,fin)
            return TonelessSyllable.new(ini,fin)  if apply_rules(type, (ini.send(type)||'') + (fin.send(type)||'')) == string
          end
        end
      end
    end
    
    def self.unparse(type, tsyll)
      if tsyll.initial.send(type)
        apply_rules(type, tsyll.initial.send(type) + (tsyll.final.send(type) || ''))
      elsif tsyll.final.respond_to?(type.to_s+'_standalone') && standalone = tsyll.final.send(type.to_s+'_standalone')
        standalone
      else
        apply_rules(type, tsyll.final.send(type))
      end
    end

    def self.tokenize(str)
      returning [] do |ary|
        str,pos = str.dup, 0
        while s=str.slice!(/[^' ]*/) and s != ""
          ary << [s.strip, pos]
          pos+=s.length
          str.slice!(/[' ]/)
        end
      end
    end
    
    private
      def self.apply_rules(type, string)
        returning string.dup do |s|
          @@rules[type] && @@rules[type].each do |rule|
            s.gsub!(Regexp.new(rule['match']),rule['subst'])
          end
        end
      end

  end
end

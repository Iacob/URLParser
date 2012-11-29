#!/usr/bin/ruby -W

require 'uri'

class StringReader
  
  def initialize(str)
    @str = str
    @chars = (@str.nil?)?[] : str.chars.to_a
    @idx = 0
  end
  
  def next_char
    ch = @chars[@idx]
    @idx = @idx.succ
    return ch
  end
end

def convert_hex_to_int(hex)
  case hex
  when '1'
    return 1
  when '2'
    return 2
  when '3'
    return 3
  when '4'
    return 4
  when '5'
    return 5
  when '6'
    return 6
  when '7'
    return 7
  when '8'
    return 8
  when '9'
    return 9
  when 'A'
    return 10
  when 'B'
    return 11
  when 'C'
    return 12
  when 'D'
    return 13
  when 'E'
    return 14
  when 'F'
    return 15
  when 'a'
    return 10
  when 'b'
    return 11
  when 'c'
    return 12
  when 'd'
    return 13
  when 'e'
    return 14
  when 'f'
    return 15
  else
    return nil
  end
end

def read_hex_value(strReader)
  
  ch1 = strReader.next_char
  ch2 = strReader.next_char
  
  ch1 = convert_hex_to_int ch1
  ch2 = convert_hex_to_int ch2
  
  if ch1.nil? or ch2.nil?
    return nil
  else
    return (ch1 * 16 + ch2).chr
  end
  
end

def escape_param_str(str)
  
  return nil if str.nil?

  result = ""

  sr = StringReader.new(str)

  ch = sr.next_char
  while !ch.nil?
  
    if ch == '%'
      hex_val = read_hex_value(sr)
      if hex_val.nil?
        print "invalid parameter hex value"
        return nil
      else
        result += hex_val
      end
    else
      result += ch
    end
    
    ch = sr.next_char
  end
  
  return result
  
end

# Get URL from command line
uri_str = ARGV[0]

if uri_str.nil?
  print "URL must not be null"
  exit 1
end

uri_pieces = URI.split(uri_str).to_a
param_str = uri_pieces[7]

param_expr = param_str.split('&')

param_hash = {}

param_expr.each do |item|
  param_kv = item.split('=')
  param_hash[escape_param_str(param_kv[0])] = escape_param_str(param_kv[1])
end

param_hash.each_key do |key|
  print key ,":", " ", param_hash[key], "\n"
end

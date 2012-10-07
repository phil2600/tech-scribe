require 'msf/core'

###
# Custom encoder that creates the following:
#   | key | cipher | key | cipher | key | cipher | ...
# where key is a random byte used to XOR the original value
# to get the cipher.
# This need a custom deencoder
###
class Metasploit3 < Msf::Encoder

   Rank = LowRanking

   def initialize
      super(
         'Name'             => 'Random XOR byte-based encoder',
         'Version'          => '1.0',
            'Description'      => %q{
            XOR encode each byte with a random byte. Result is random byte + rslt.
         },
         'Author'           => 'Nicolas Biscos',
         'Arch'             => ARCH_ALL,
         'License'          => BSD_LICENSE)
   end

   def encode_block(state, buf)
      rslt = ""
      buf.each_byte do |c|
         r = rand(0xff)
         rslt += r.chr
         rslt += (c^r).chr    
      end
      rslt
   end

end

#--
# Copyright (c) 2011 David Kellum
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License.  You may
# obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.  See the License for the specific language governing
# permissions and limitations under the License.
#++

require 'mojibake/mapper'
require 'json'

module MojiBake

  class Mapper

    # table as self contained json-ready Hash
    def json_object

      # Also use unicode excape for the "interesting" subset of moji
      # mappings.
      moji = hash.sort.map do |kv|
        kv.map do |s|
          s.codepoints.inject( '' ) do |r,i|
            if INTEREST_CODEPOINTS.include?( i )
              r << sprintf( '\u%04X', i )
            else
              r << i.chr( Encoding::UTF_8 )
            end
          end
        end
      end

      { :mojibake => MojiBake::VERSION,
        :url => "https://github.com/dekellum/mojibake",
        :regexp => regexp.inspect[1...-1],
        :moji =>  Hash[ moji ] }
    end

    # Pretty formatted JSON serialized String for json_object
    def json
      # Generate and replace what become double escaped '\\u' UNICODE
      # escapes with '\u' escapes. This is a hack but is reasonably
      # safe given that 'u' isn't normally escaped.  The alterantive
      # would be to hack JSON package or do the JSON formatting
      # ourselves.
      JSON.pretty_generate( json_object ).gsub( /\\\\u/, '\u' )
    end

  end
end
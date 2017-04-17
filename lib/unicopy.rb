# enable-frozen-string: true

require_relative "unicopy/version"

require "clipboard"

module Unicopy
  DUMP_FORMATS = {
    'hex' => {
      description: "____ (hexadecimal)",
      replace: "%X",
      alias: "x",
    },
    'uplus' => {
      description: "U+____ (hexadecimal)",
      replace: "U+%04X",
      alias: "u",
    },
    '0x' => {
      description: "0x____ (hexadecimal)",
      replace: "0x%04X",
      alias: "0",
    },
    'dec' => {
      description: "____ (decimal)",
      replace: "%d",
      alias: "d",
    },
    'ruby' => {
      description: "Ruby \\u{____} (hexadecimal)",
      prefix: "\\u{",
      replace: "%X",
      suffix: "}",
      alias: "r",
    },
    'css' => {
      description: "CSS \\____ (hexadecimal)",
      replace: "\\%x",
      joiner: "",
      suffix: " ",
    },
    'js' => {
      description: "JavaScript \\u____ with UTF-16 surrogates (hexadecimal)",
      replace: ->(x){
        [x].pack("U").encode("UTF-16BE").each_byte.each_slice(2).map{ |a,b| "\\u%04X" % (a*256 + b) }
      },
      joiner: "",
    },
    'es6' => {
      description: "EcmaScript 6+ \\u{____} (hexadecimal)",
      replace: "\\u{%X}",
      joiner: "",
      alias: "6",
    },
    'html-hex' => {
      description: "HTML entitiy &#x____ (hexadecimal)",
      replace: "&#x%X;",
      joiner: "",
    },
    'html-dec' => {
      description: "HTML entitiy &#____ (decimal)",
      replace: "&#%d;",
      joiner: "",
    },
    'bytes-utf8' => {
      description: "UTF-8 encoded (bytes)",
      replace: ->(x){
        [x].pack("U").unpack("C*").map{ |x| x.to_s(16).upcase }.join(" ")
      },
    }
  }
  DUMP_FORMAT_DEFAULTS = {
    prefix: "",
    replace: "%s",
    joiner: " ",
    suffix: "",
  }

  def self.unicopy(*args, string: false, dump: nil, parse_decimal: false, print: false)
    if args.empty?
      raise ArgumentError, "no data given to copy"
    elsif !string
      codepoints = transform_raw_codepoints(args.join(" ").split(" "), parse_decimal)
      if dump
        deliver(dump_codepoints(codepoints, format: dump), print: print, codepoints_length: codepoints.length, message: "dump of")
      else # default
        deliver(codepoints.pack("U*"), print: print, codepoints_length: codepoints.length, message: "string of")
      end
    else
      data = args.join("")
      data = data.encode("UTF-8") unless data.encoding.name == "UTF-8"
      codepoints = data.unpack("U*")

      deliver(dump_codepoints(codepoints, format: dump), print: print, codepoints_length: codepoints.length, message: "dump of")
    end
  end

  def self.deliver(output, print: false, message: "", codepoints_length:)
    if print
      puts(output)
    else
      Clipboard.copy(output)
      puts Paint["Copied #{message} #{codepoints_length} codepoint#{codepoints_length != 1 ? "s" : ""} to clipboard", :green]
    end
  end

  def self.transform_raw_codepoints(codepoints, parse_decimal = false)
    if parse_decimal
      parse_numerals_regex = /\A([0-9]+)\z/
      numeral_base = 10
    else
      parse_numerals_regex = /\A(?:U\+)?(\h+)\z/
      numeral_base = 16
    end

    codepoints.map{ |cp|
      case cp
      when Integer
        cp
      when parse_numerals_regex
        $1.to_i(numeral_base)
      else
        raise ArgumentError, "unicopy does not understand codepoint \"#{cp}\". Please pass hexadecimal codepoint values, separated by spaces, or use --string option"
      end
    }.tap{ |codepoints|
      codepoints.pack("U*").valid_encoding? or raise ArgumentError, "invalid codepoints passed to unicopy"
    }
  end

  def self.dump_codepoints(codepoints, format: nil)
    format ||= "uplus"
    if dump_format_details = DUMP_FORMATS[format]
      prefix  = dump_format_details[:prefix]  || DUMP_FORMAT_DEFAULTS[:prefix]
      replace = dump_format_details[:replace] || DUMP_FORMAT_DEFAULTS[:replace]
      joiner  = dump_format_details[:joiner]  || DUMP_FORMAT_DEFAULTS[:joiner]
      suffix  = dump_format_details[:suffix]  || DUMP_FORMAT_DEFAULTS[:suffix]
    else
      raise ArgumentError, "unicopy does not know dump format \"#{format}\""
    end

    prefix + codepoints.map{ |cp| replace.is_a?(Proc) ? replace[cp] : replace % cp }.join(joiner) + suffix
  end
end

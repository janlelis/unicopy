require_relative "../lib/unicopy/kernel_method"
require "minitest/autorun"

describe Unicopy do
  it "converts codepoints to string and, with --print, outputs it to STDOUT" do
    assert_output(/Ruby 🌫/){ unicopy("52 75 62 79 20 1F32B", print: true) }
  end

  it "also works with U+ prefixes" do
    assert_output(/Ruby 🌫/){ unicopy("U+0052 U+0075 U+0062 U+0079 U+0020 U+1F32B", print: true) }
  end

  it "parses codepoints as decimal if --parse-decimal option is given" do
    assert_output(/4K>O/){ unicopy("52 75 62 79", print: true, parse_decimal: true) }
  end

  it "will convert string to codepoints with --string option" do
    assert_output(Regexp.compile(Regexp.escape("U+0052 U+0075 U+0062 U+0079 U+0020 U+1F32B"))){
      unicopy("Ruby 🌫", print: true, string: true)
    }
  end

  it "works with non-UTF-8 input" do
    assert_output(Regexp.compile(Regexp.escape("U+0052 U+0075 U+0062 U+0079 U+0020 U+1F32B"))){
      unicopy("Ruby 🌫".encode("UTF-16LE"), print: true, string: true)
    }
  end

  describe "[dump formats]" do
    it "dumps hex" do
      assert_output(Regexp.compile(Regexp.escape("52 75 62 79 20 1F32B"))){
        unicopy("52 75 62 79 20 1F32B", print: true, dump: "hex")
      }
    end

    it "dumps hex (string input)" do
      assert_output(Regexp.compile(Regexp.escape("52 75 62 79 20 1F32B"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "hex")
      }
    end

    it "dumps uplus (string input) [default]" do
      assert_output(Regexp.compile(Regexp.escape("U+0052 U+0075 U+0062 U+0079 U+0020 U+1F32B"))){
        unicopy("Ruby 🌫", print: true, string: true)
      }
    end

    it "dumps 0x (string input)" do
      assert_output(Regexp.compile(Regexp.escape("0x0052 0x0075 0x0062 0x0079 0x0020 0x1F32B"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "0x")
      }
    end

    it "dumps dec (string input)" do
      assert_output(Regexp.compile(Regexp.escape("82 117 98 121 32 127787"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "dec")
      }
    end

    it "dumps ruby (string input)" do
      assert_output(Regexp.compile(Regexp.escape("\\u{52 75 62 79 20 1F32B}"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "ruby")
      }
    end

    it "dumps js (string input)" do
      assert_output(Regexp.compile(Regexp.escape("\\u0052\\u0075\\u0062\\u0079\\u0020\\uD83C\\uDF2B"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "js")
      }
    end

    it "dumps es6 (string input)" do
      assert_output(Regexp.compile(Regexp.escape("\\u{52}\\u{75}\\u{62}\\u{79}\\u{20}\\u{1F32B}"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "es6")
      }
    end

    it "dumps css (string input)" do
      assert_output(Regexp.compile(Regexp.escape("\\52\\75\\62\\79\\20\\1f32b"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "css")
      }
    end

    it "dumps html-hex (string input)" do
      assert_output(Regexp.compile(Regexp.escape("&#x52;&#x75;&#x62;&#x79;&#x20;&#x1F32B;"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "html-hex")
      }
    end

    it "dumps html-dec (string input)" do
      assert_output(Regexp.compile(Regexp.escape("&#82;&#117;&#98;&#121;&#32;&#127787;"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "html-dec")
      }
    end

    it "dumps bytes-utf8 (string input)" do
      assert_output(Regexp.compile(Regexp.escape("52 75 62 79 20 F0 9F 8C AB"))){
        unicopy("Ruby 🌫", print: true, string: true, dump: "bytes-utf8")
      }
    end
  end
end

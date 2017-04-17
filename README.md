# unicopy [![[version]](https://badge.fury.io/rb/unibits.svg)](http://badge.fury.io/rb/unibits)  [![[travis]](https://travis-ci.org/janlelis/unibits.svg)](https://travis-ci.org/janlelis/unibits)

CLI utility which converts Unicode codepoints to a string (or vice versa). Copies the result to the system clipboard or just prints it to the console.

Can also convert codepoints to many dump formats.

## Setup

Make sure you have Ruby installed and installing gems works properly. Then do:

```
$ gem install unicopy
```

## Usage

### Codepoints to String

Codepoints format is hexadecimal, "U+" is permitted, examples:

```ruby
$ unicopy 52 75 62 79 --print
Ruby
```

```ruby
$ unicopy U+0052 U+0075 U+0062 U+0079 --print
Ruby
```

### String to Codepoints

```ruby
$ unicopy --string Ruby --print
U+0052 U+0075 U+0062 U+0079
```

### Options

```
--help                |    | this help page
--parse-decimal       |    | interpret given codepoints as decimal, instead of hexadecimal values
--print               | -p | do not copy to system clipboard, but print to screen
--string              | -s | see above
--version             |    | displays version of unicopy
--(dump format)       |    | specify the format to be used for dumping the codepoints (see below)
```

### Dump Formats

#### Short Hexadecimal

```
$ unicopy 52 75 62 79 20 1F32B --print --hex
52 75 62 79 20 1F32B
```

```
$ unicopy --string "Ruby 🌫" --print --hex
52 75 62 79 20 1F32B
```

#### Hexadecimal With `U+` Prefix

```
$ unicopy 52 75 62 79 20 1F32B --print --uplus
U+0052 U+0075 U+0062 U+0079 U+0020 U+1F32B
```

```
$ unicopy --string "Ruby 🌫" --print --uplus
U+0052 U+0075 U+0062 U+0079 U+0020 U+1F32B
```

#### Hexadecimal With `0x` Prefix

```
$ unicopy 52 75 62 79 20 1F32B --print --0x
0x0052 0x0075 0x0062 0x0079 0x0020 0x1F32B
```

```
$ unicopy --string "Ruby 🌫" --print --0x
0x0052 0x0075 0x0062 0x0079 0x0020 0x1F32B
```

#### Decimal

```
$ unicopy 52 75 62 79 20 1F32B --print --dec
82 117 98 121 32 127787
```

```
$ unicopy --string "Ruby 🌫" --print --dec
82 117 98 121 32 127787
```

#### Ruby Escape Syntax

```
$ unicopy 52 75 62 79 20 1F32B --print --ruby
\\u{52 75 62 79 20 1F32B}
```

```
$ unicopy --string "Ruby 🌫" --print --ruby
\\u{52 75 62 79 20 1F32B}
```

#### JavaScript Escape Syntax (Since ES6)

```
$ unicopy 52 75 62 79 20 1F32B --print --es6
\\u{52}\\u{75}\\u{62}\\u{79}\\u{20}\\u{1F32B}
```

```
$ unicopy --string "Ruby 🌫" --print --es6
\\u{52}\\u{75}\\u{62}\\u{79}\\u{20}\\u{1F32B}
```

#### JavaScript Escape Syntax (Before ES6)

```
$ unicopy 52 75 62 79 20 1F32B --print --js
\\u0052\\u0075\\u0062\\u0079\\u0020\\uD83C\\uDF2B
```

```
$ unicopy --string "Ruby 🌫" --print --js
\\u0052\\u0075\\u0062\\u0079\\u0020\\uD83C\\uDF2B
```

#### CSS Escape Syntax

```
$ unicopy 52 75 62 79 20 1F32B --print --css
\\52\\75\\62\\79\\20\\1f32b
```

```
$ unicopy --string "Ruby 🌫" --print --css
\\52\\75\\62\\79\\20\\1f32b
```

#### Hexadecimal HTML Entities

```
$ unicopy 52 75 62 79 20 1F32B --print --html-hex
&#x52;&#x75;&#x62;&#x79;&#x20;&#x1F32B;
```

```
$ unicopy --string "Ruby 🌫" --print --html-hex
&#x52;&#x75;&#x62;&#x79;&#x20;&#x1F32B;
```

#### Decimal HTML Entities

```
$ unicopy 52 75 62 79 20 1F32B --print --html-dec
&#82;&#117;&#98;&#121;&#32;&#127787;
```

```
$ unicopy --string "Ruby 🌫" --print --html-dec
&#82;&#117;&#98;&#121;&#32;&#127787;
```

#### UTF-8 in Hexadecimal Bytes

```
$ unicopy 52 75 62 79 20 1F32B --print --bytes-utf8
52 75 62 79 20 F0 9F 8C AB
```

```
$ unicopy --string "Ruby 🌫" --print --bytes-utf8
52 75 62 79 20 F0 9F 8C AB
```

## Also see

- [unibits](https://github.com/janlelis/unibits)
- [uniscribe](https://github.com/janlelis/uniscribe)

Copyright (C) 2017 Jan Lelis <http://janlelis.com>. Released under the MIT license.

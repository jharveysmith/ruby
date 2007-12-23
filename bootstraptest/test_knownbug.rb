#
# This test file concludes tests which point out known bugs.
# So all tests will cause failure.
#

assert_equal 'ok', %q{
  open("require-lock-test.rb", "w") {|f|
    f.puts "sleep 0.1"
    f.puts "module M"
    f.puts "end"
  }
  $:.unshift Dir.pwd
  vs = (1..2).map {|i|
    Thread.start {
      require "require-lock-test"
      M
    }
  }.map {|t| t.value }
  vs[0] == M && vs[1] == M ? :ok : :ng
}, '[ruby-dev:32048]'

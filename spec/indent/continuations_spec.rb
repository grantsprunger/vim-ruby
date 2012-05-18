require 'spec_helper'

describe "Indenting" do
  specify "tricky string interpolation" do
    # See https://github.com/vim-ruby/vim-ruby/issues/75 for details
    assert_correct_indenting <<-EOF
      puts %{\#{}}
      puts "OK"
    EOF

    assert_correct_indenting <<-EOF
      while true
        begin
          puts %{\#{x}}
        rescue ArgumentError
        end
      end
    EOF
  end

  specify "continuations after round braces" do
    assert_correct_indenting <<-EOF
      opts.on('--coordinator host=HOST[,port=PORT]',
              'Specify the HOST and the PORT of the coordinator') do |str|
        h = sub_opts_to_hash(str)
        puts h
      end
    EOF
  end

  specify "continuations after assignment" do
    assert_correct_indenting <<-EOF
      variable =
        if condition?
          1
        else
          2
        end
    EOF

    assert_correct_indenting <<-EOF
      variable = # evil comment
        case something
        when 'something'
          something_else
        else
          other
        end
    EOF
  end
end

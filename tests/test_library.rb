require 'minitest/autorun'
require_relative '../library'

class TestLibrary < Minitest::Test
  def setup
    @library = Library.new
  end

  def test_initialize
    assert_empty @library.instance_variable_get(:@articles)
  end

  def test_search_article
    # user input
    allow_user_input("Writer Name", "Your Name") do
      @library.send(:search_article)
    end

    articles = @library.instance_variable_get(:@articles)
    refute_empty articles
    assert_instance_of Article, articles.first
    assert_equal "Writer Name", articles.first.attr_writer
    assert_equal "Your Name", articles.first.attr_reader
  end

  def test_show_articles
    # article samples to test
    @library.instance_variable_set(:@articles, [
      Article.new("Writer1", "Reader1"),
      Article.new("Writer2", "Reader2")
    ])

    # Redirect standard output to a string for subsequent assertions
    output = capture_io do
      @library.send(:show_articles)
    end

    assert_match /Writer1/, output
    assert_match /Reader1/, output
    assert_match /Writer2/, output
    assert_match /Reader2/, output
  end

  def test_run_with_invalid_option
    # test run with invalid option
    output = capture_io do
      allow_user_input("5") do
        @library.run
      end
    end

    assert_match /Invalid option selected/, output
  end

  def test_run_with_exit_option
    # user exit
    output = capture_io do
      allow_user_input("3") do
        @library.run
      end
    end

    assert_match /GoodBye!/, output
  end

  private

  def allow_user_input(*input)
    $stdin = StringIO.new
    input.flatten.each { |i| $stdin.puts(i) }
    $stdin.rewind
    yield if block_given?
  ensure
    $stdin = STDIN
  end

  def capture_io
    output = StringIO.new
    $stdout = output
    $stderr = output
    yield
    output.string
  ensure
    $stdout = STDOUT
    $stderr = STDERR
  end
end

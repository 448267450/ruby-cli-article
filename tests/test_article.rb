require 'minitest/autorun'
require_relative '../article'

class TestLibrary < Minitest::Test
  def setup
    @article = Article.new
  end

  def test_initialize
    assert_empty @article.instance_variable_get(:@articles)
  end

  def test_search_article
    # user input
    allow_user_input("Charles Dickens", "John Doe") do
      @article.send(:search_article)
    end

    articles = @article.instance_variable_get(:@articles)
    refute_empty articles
    assert_instance_of Hash, articles.first
    assert_equal "Charles Dickens", articles.first[:author]
    assert_equal "Great Expectations was selected!", articles.first[:book]
    assert_equal "John Doe", articles.first[:reader]
  end

  def test_show_articles
    # article samples to test
    @article.instance_variable_set(:@articles, [
      { author: "Writer1", book: "Book1", reader: "Reader1" },
      { author: "Writer2", book: "Book2", reader: "Reader2" }
    ])

    # Redirect standard output to a string for subsequent assertions
    output = capture_io do
      @article.send(:show_articles)
    end

    assert_match /Writer1/, output
    assert_match /Book1/, output
    assert_match /Reader1/, output
    assert_match /Writer2/, output
    assert_match /Book2/, output
    assert_match /Reader2/, output
  end

  def test_run_with_invalid_option
    # test run with invalid option
    output = capture_io do
      allow_user_input("5") do
        @article.run
      end
    end

    assert_match /Invalid option selected/, output
  end

  def test_run_with_exit_option
    # user exit
    output = capture_io do
      allow_user_input("3") do
        @article.run
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

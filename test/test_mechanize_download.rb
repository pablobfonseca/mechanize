require 'helper'

class TestMechanizeDownload < MiniTest::Unit::TestCase

  def setup
    @parser = Mechanize::Download
  end

  def test_save_string_io
    uri = URI.parse 'http://example/foo.html'
    body_io = StringIO.new '0123456789'

    download = @parser.new uri, nil, body_io

    Dir.mktmpdir do |dir|
      Dir.chdir dir do
        download.save

        assert File.exist? 'foo.html'
      end
    end
  end

  def test_save_tempfile
    uri = URI.parse 'http://example/foo.html'
    Tempfile.new __name__ do |body_io|
      body_io.write '0123456789'

      body_io.flush
      body_io.rewind

      download = @parser.new uri, nil, body_io

      Dir.mktmpdir do |dir|
        Dir.chdir dir do
          download.save

          assert File.exist? 'foo.html'
        end
      end
    end
  end

end

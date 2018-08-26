require 'cuba'

Cuba.define do
  def read_fixture(*path)
    File.read [File.dirname(__FILE__), '..', 'fixtures', *path].join('/')
  end

  on get do
    on 'posts/:id' do |id|
      res.write read_fixture('posts', id)
    end
  end
end

# If this file is loaded from the command line, start the server
Rack::Handler::WEBrick.run(Cuba) if $PROGRAM_NAME == __FILE__

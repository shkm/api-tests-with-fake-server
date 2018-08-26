require 'net/http'
require 'json'

class ApiPost
  DEFAULT_ENDPOINT = 'https://schembri.me/api'.freeze

  attr_reader :id, :title, :content

  def self.get(id)
    json = JSON.parse(Net::HTTP.get(endpoint('posts', id)),
                      symbolize_names: true)

    new json
  end

  private_class_method def self.endpoint(*path)
    URI.parse(
      [ENV.fetch('API_ENDPOINT', DEFAULT_ENDPOINT), *path].join('/')
    )
  end

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @title = attributes[:title]
    @content = attributes[:content]
  end
end

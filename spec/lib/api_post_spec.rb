require 'api_post'

RSpec.describe ApiPost do
  around &method(:with_fake_server)

  describe '.get' do
    it 'returns a valid ApiPost object' do
      api_post = ApiPost.get(1)

      expect(api_post.id).to eq 1
      expect(api_post.title).to eq 'Our post'
      expect(api_post.content).to eq 'Such content, very post'
    end
  end
end

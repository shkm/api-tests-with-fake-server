RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  def with_fake_server(example)
    # Set the API endpoint to the fake server,
    # saving the current value for later
    old_api_endpoint = ENV['API_ENDPOINT']
    ENV['API_ENDPOINT'] = 'http://localhost:8080'

    # Boolean to check whether the server has started. This will
    # be flipped later.
    server_started = false

    # Start the server in a new thread, so we don't block execution
    # and can actually run our tests in this thread.
    Thread.new do
      require_relative '../servers/fake_api_server.rb'
      Rack::Handler::WEBrick.run(
        Cuba,
        Logger: WEBrick::Log.new(File.open(File::NULL, 'w')),
        AccessLog: [],
        StartCallback: -> { server_started = true }
      )
    end

    # Wait until we know the server is ready
    sleep(0.1) until server_started

    # Run our tests
    example.run

    # Switch the API_ENDPOINT back to what it was before
    ENV['API_ENDPOINT'] = old_api_endpoint
  end
end

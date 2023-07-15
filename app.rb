class App
  def call(env)
    headers = {
      'Content-Type' => 'text/html'
    }

    response = prepare_response(env)

    [200, headers, response]
  end

  private

  def prepare_response(env)
    return users if env['REQUEST_PATH'].include?('/users')
    return posts if env['REQUEST_PATH'].include?('/posts')

    ['Wrong url']
  end

  def data
    return @data unless @data.nil?

    require 'json'
    file = File.open("./data.json")
    @data = JSON.load(file)
  end

  def users
    [data['users']]
  end

  def posts
    [data['posts']]
  end
end

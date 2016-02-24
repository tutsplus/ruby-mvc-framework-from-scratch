require "simplemvc/version"
require "simplemvc/controller.rb"
require "simplemvc/utils.rb"
require "simplemvc/dependencies.rb"
require "simplemvc/routing.rb"
require "simplemvc/mapper.rb"

module Simplemvc
  class Application
    def call(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [ 500, { }, [] ]
      end
      get_rack_app(env).call(env)
    end

  end
end

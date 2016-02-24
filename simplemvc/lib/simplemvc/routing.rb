module Simplemvc

  class Router
    def initialize
      # regexp, target
      @routes = []
    end
    
    def match(url, *args)
      target = nil
      target = args.shift if args.size > 0

      url_parts = url.split("/")
      url_parts.select! { |part| !part.empty? }

      placeholders = []
      regexp_parts = url_parts.map do |part|
        if part[0] == ":"
          placeholders << part[1..-1]
          "([A-Za-z0-9_]+)"
        else
          part
        end
      end

      regexp = regexp_parts.join('/')
      @routes << {
        regexp: Regexp.new("^/#{regexp}$"),
        target: target,
        placeholders: placeholders
      }
    end

    def check_url(url)
      @routes.each do |route|
        match = route[:regexp].match(url)
        if match
          # { controller: "haha", action: "hehe" }
          placeholders = {}
          route[:placeholders].each_with_index do |placeholder, index|
            placeholders[placeholder] = match.captures[index]
          end

          if route[:target]
            return convert_target(route[:target])
          else
            controller = placeholders["controller"]
            action = placeholders["action"]            
            return convert_target("#{controller}##{action}")
          end

        end
      end
    end

    def convert_target(target)
      if target =~ /^([^#]+)#([^#]+)$/
        controller_name = $1.to_camel_case
        controller = Object.const_get("#{controller_name}Controller")
        return controller.action($2)
      end
    end
    
  end

  class Application
    def route(&block)
      @router ||= Simplemvc::Router.new
      @router.instance_eval(&block)
    end

    def get_rack_app(env)
      @router.check_url(env["PATH_INFO"])
    end
  end

end

#
# Jira
#
module ReleaseManager
  module AuthOptionBuilder
    class Jira < Base
      class << self
        def build_auth_options_by_tty(options = {})
          puts 'Login will be required...'
          prompt = TTY::Prompt.new

          result = prompt.collect do
            key(:site).ask('Site (ex: https://myjira.atlassian.net):', required: true)
            key(:context_path).ask('Jira path in your site (just press enter if you don\'t have):', default: '')
            key(:username).ask('Username:', required: true)
            key(:password).mask('Password:', required: true)
            key(:project).ask('Project (ex: OA)', required: true)
          end

          result[:auth_type] = :basic
          result[:use_ssl] ||= false if result[:site] =~ /http\:\/\//

          result
        end

        def auth_cache_key
          'auth-jira'
        end
      end
    end
  end
end

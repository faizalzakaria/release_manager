require 'capistrano'

namespace :deploy do
  after :finished, 'release_manager:deploy'
end

namespace :release_manager do
  desc "Release manager"
  task :deploy do
    role = roles(:all, select: :primary).first || roles(:all).first
    on role do
      within release_path do
        with rails_env: fetch(:rails_env, fetch(:stage)) do
          invoke 'release_manager:generate_release'
          invoke 'release_manager:post_to_slack'
          info 'Test Release Manager'
        end
      end
    end
  end

  task :generate_release do
    role = roles(:all, select: :primary).first || roles(:all).first
    on role do
      within release_path do
        with rails_env: fetch(:rails_env, fetch(:stage)) do
          info 'Genrate release'
          generate_release
        end
      end
    end
  end

  task :post_to_slack do
    role = roles(:all, select: :primary).first || roles(:all).first
    on role do
      within release_path do
        with rails_env: fetch(:rails_env, fetch(:stage)) do
          info 'Post to slack'
          post_to_slack
        end
      end
    end
  end

  def generate_release

    puts 'hell'
  end

  def post_to_slack
    puts 'hello'
  end
end

# frozen_string_literal: true

namespace :create_superuser do
  desc 'I am short, but comprehensive description for my cool task'
  task :run, %i[username password first_name last_name email] => :environment do |_t, args|
    User.create do |user|
      user.first_name = args.first_name || ''
      user.last_name = args.last_name || ''
      user.email = args.email || 'root@gmail.com'
      user.username = args.username
      user.password = args.password
      user.status = Status.where(active: true).first
    end
  end
end

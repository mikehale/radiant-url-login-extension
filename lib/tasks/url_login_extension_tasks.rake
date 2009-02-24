namespace :radiant do
  namespace :extensions do
    namespace :link_authenticate do

      desc "Runs the migration of the Link Authenticate extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          UrlLoginExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          UrlLoginExtension.migrator.migrate
        end
      end

      desc "Copies public assets of the Link Authenticate to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[UrlLoginExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(UrlLoginExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end
    end
  end
end

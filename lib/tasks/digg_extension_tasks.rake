namespace :radiant do
  namespace :extensions do
    namespace :digg do
      
      desc "Runs the migration of the Digg extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          DiggExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          DiggExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Digg to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[DiggExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(DiggExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end

module Lesstidy
  class Config
    class << self
      NoRootError = Class.new(Exception)

      def paths
        r = []
        begin
          r << find_project_root
        rescue NoRootError; end
        r
      end

      def find_project_root(start = Dir.pwd)
        check = File.expand_path(start)
        ret = nil
        while ret.nil?
          # See if any of these files exist
          ['.lesstidy'].each do |config_name|
            config_file = File.join(check, config_name)
            ret ||= [check, config_file]  if File.directory? config_file
          end

          # Traverse back (die if we reach the root)
          old_check = check
          check = File.expand_path(File.join(check, '..'))
          raise NoRootError  if check == old_check
        end
        ret
      end
    end
  end
end

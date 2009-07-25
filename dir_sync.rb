require 'FileUtils'

class DirSync
  
  def self.make_destination destination
    FileUtils.mkdir(destination) unless File.directory?(destination)
  end
  
  def self.sync source, destination
      changed = false
      
      self.make_destination destination
      
      Dir.glob(source + '/*').each do |file|
        tofile = destination + '/' + File.basename(file)
        
        if FileUtils.uptodate?(file, tofile)
          FileUtils.cp_r file, tofile
          changed = true
          puts "'#{file}' copied to '#{tofile}'."
        end
      end
      
      changed
  end
  
end
require 'FileUtils'

class DirSync
  
  def self.make_dest destination
    FileUtils.mkdir(destination) unless File.directory?(destination)
  end
  
  def self.sync source, destination      
      self.make_dest destination
      changed = self.copy_new source, destination
      self.clean_dest source, destination
      
      changed
  end
  
  def self.copy_new source, destination
    made_changes = false
    
    Dir.foreach(source) { |file|
      from = File.join(source, file)
      to = File.join(destination, file)
      
      if FileUtils.uptodate?(from, to)
        FileUtils.cp_r from, to
        puts "Copied files from #{source} to #{destination}:" unless made_changes
        made_changes = true
        puts "  #{file}"
      end
    }
    
    made_changes
  end
  
  def self.clean_dest source, destination
    made_changes = false
    
    Dir.foreach(destination) { |file| 
      tmp = File.join(source, file)
      if !File.exist?(tmp)
        FileUtils.rm File.join(destination, file)
        puts "Deleted unmatched file from destination directory:" unless made_changes
        made_changes = true
        puts "  #{file}"
      end
    }
  end
end
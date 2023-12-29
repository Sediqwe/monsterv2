module BackupHelper
    def windows_compatible_file_name(filename)
        filename = filename.gsub(":", "_")
        filename = filename.gsub(" ", "_")
        return filename
      end
end

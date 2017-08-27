class CleanupLocalMediaJob < ApplicationJob
  queue_as :high_priority

  def perform
    Dir.glob(Rails.root.join('tmp', 'youtube', '**', '*')).each do |path|
      if File.mtime(path) < 3.hours.ago
        next unless File.file?(path)
        Rails.logger.info "Removing outdated tmp file: #{path}"
        FileUtils.rm(path) 
      end
    end
  end
end

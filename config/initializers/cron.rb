begin
  Delayed::Job.where.not(cron: nil).delete_all
  UpdateAllPodcastsJob.set(cron: '*/10 * * * *').perform_later
  CleanupLocalMediaJob.set(cron: '3 * * * *').perform_later
  CleanupOutdatedJob.set(cron: '33 * * * *').perform_later
rescue
  Rails.logger.error "Faild to set cron jobs"
end

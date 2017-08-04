class ApplicationJob < ActiveJob::Base
  # Without that, a default async backand is used.
  self.queue_adapter = :delayed_job
end

class ApplicationJob < ActiveJob::Base
  # FIXME: Without that, a default async backand is used.
  self.queue_adapter = :sucker_punch

  around_perform :with_db_connection

  private

  def with_db_connection
    ActiveRecord::Base.connection_pool.with_connection do
      Rails.logger.info 'WITH DB CONNECTION'
      yield
    end
  end
end

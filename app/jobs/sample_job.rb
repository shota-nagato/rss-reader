class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "SampleJob is running"
    sleep 5
    Rails.logger.info "SampleJob is done"
  end
end

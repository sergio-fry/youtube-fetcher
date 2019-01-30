class YoutubeVideoList
  attr_reader :origin_id

  class NotFound < StandardError; end;

  def initialize(origin_id)
    @origin_id = origin_id
  end

  def exists?
    true
  end
end

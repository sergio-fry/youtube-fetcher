require 'rails_helper'

RSpec.describe FetchVideoEpisodeJob, type: :job do
  include MediaFilesHelper

  def perform_job
    VCR.use_cassette :fetch_video do
      job.perform(podcast, youtube_video_id)
    end
  end

  let(:job) { FetchVideoEpisodeJob.new }
  let(:podcast) { FactoryGirl.create :podcast, updated_at: 1.day.ago}
  let(:youtube_video_id) { 'fdpdN6K6ntY' }
  let(:video_cdn_url) do
    'https://r17---sn-n8v7znly.googlevideo.com/videoplayback?itag=18&mn=sn-n8v7znly&ip=94.228.243.75&mm=31&ipbits=0&pl=24&id=o-AKwcp_UIx2hmfNK88JrzSBU2TxABfPipXJW2dZkBlK1S&mv=m&mt=1513582539&ms=au&key=yt6&mime=video%2Fmp4&expire=1513604269&ei=THA3WoDgLIy3d8CHpcgH&signature=9B8FE971772C7DFAC441AFB9331F82FAC73A2324.2D2521FD8610521EBC380479C1E9E65F1788A758&initcwndbps=1007500&gir=yes&clen=28865556&ratebypass=yes&nh=IgpwcjAxLnN2bzAzKgkxMjcuMC4wLjE&lmt=1499849951866768&dur=608.060&source=youtube&requiressl=yes&sparams=clen%2Cdur%2Cei%2Cgir%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cnh%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cexpire'
  end

  before do
    allow(Tracker).to receive(:event)
    allow_any_instance_of(YoutubeDl).to receive(:fetch_video_url) { video_cdn_url }
    Rails.cache.clear
    allow(UserAgentsPool).to receive(:has_free_users?) { true }
  end

  it 'should save media' do
    expect do
      perform_job
    end.to change { podcast.video_episodes.count }.by(1)
  end

  describe 'new episode' do
    before { perform_job }
    subject { podcast.video_episodes.first }

    it { is_expected.to be_present }

    it 'should have media' do
      expect(subject.media).to be_blank
    end

    its(:title) { is_expected.to eq 'Порошенко и дети' }
    its(:published_at) { is_expected.to be_a Time }
    its(:origin_id) { is_expected.to eq youtube_video_id }
    its(:size) { is_expected.to eq 28865556 }
  end
end

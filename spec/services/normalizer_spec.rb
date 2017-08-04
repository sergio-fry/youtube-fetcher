require 'rails_helper'

RSpec.describe Normalizer do
  before do
    `rm -rf #{Rails.root.join('tmp', 'test', 'normalizer')}`
    `mkdir -p #{Rails.root.join('tmp', 'test', 'normalizer')}`
  end

  let(:normalizer) { Normalizer.new }
  let(:audio_file) do
    src = Rails.root.join('spec', 'fixtures', 'audio.mp3')
    dst = Rails.root.join('tmp', 'test', 'normalizer', 'audio.mp3')
    `cp #{src} #{dst}`

    dst
  end


  it 'should normalize' do
    expect(File.exists?(normalizer.normalize(audio_file))).to eq true
  end
end

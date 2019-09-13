require 'rails_helper'

RSpec.describe Normalizer, skip: true do
  include MediaFilesHelper

  let(:normalizer) { Normalizer.new }
  let(:audio_file) { audio_file_example_path }

  it 'should normalize' do
    expect(File.exists?(normalizer.normalize(audio_file))).to eq true
  end
end

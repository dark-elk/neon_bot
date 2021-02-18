# frozen_string_literal: true

RSpec.describe HTTP::Actions::Health::Get, type: :action do
  subject { action.call({}).status }

  let(:action) { described_class.new }

  it { is_expected.to eq(200) }
end

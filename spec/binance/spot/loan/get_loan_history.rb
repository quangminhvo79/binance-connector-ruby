# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#get_loan_history' do
  let(:path) { '/sapi/v1/loan/income' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should accept the offered quote by quote ID' do
    spot_client_signed.get_loan_history
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end

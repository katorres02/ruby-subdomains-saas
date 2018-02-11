=begin
require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Validations' do
  	it { should validate_presence_of :owner }
  	it { should validate_presence_of :subdomain }
  	it { should validate_uniqueness_of(:subdomain).ignoring_case_sensitivity }

  	it { should_not allow_value('www').for(:subdomain) }
  	it { should_not allow_value('WWW').for(:subdomain) }

  	it 'should validate case insensitive uniqueness' do
      create(:account, subdomain: 'Test')
      expect(build(:account, subdomain: 'test')).to_not be_valid
    end
  end

  describe 'Associations' do
  	it { should belong_to :owner }
  end
end
=end
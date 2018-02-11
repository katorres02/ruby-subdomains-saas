require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }

    it { should_not allow_value('www').for(:name) }
    it { should_not allow_value('WWW').for(:name) }

    it 'should validate case insensitive uniqueness' do
      create(:tenant, name: 'Test')
      expect(build(:tenant, name: 'test')).to_not be_valid
    end
  end
end

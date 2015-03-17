require 'rails_helper'

describe Business do

  describe "ActiveModel validations" do
    # http://guides.rubyonrails.org/active_record_validations.html
    # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/frames
    # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/Shoulda/Matchers/ActiveModel
    # Basic validations
    it { should validate_presence_of :name }
    it { should validate_numericality_of(:year_of_establishment).only_integer }
  end

  describe "ActiveRecord associations" do
    it { should belong_to(:category) }
    it { should have_one(:address) }
    it { should have_one(:website).dependent(:destroy) }
    it { should have_many(:phone_numbers).dependent(:destroy) }
    it { should have_many(:emails).dependent(:destroy) }
    it { should have_many(:images).dependent(:destroy) }
    it { should have_many(:time_slots).dependent(:destroy) }
    it { should have_many(:reviews) }
    it { should have_and_belong_to_many(:keywords) }
    it { should accept_nested_attributes_for(:address).allow_destroy(true) }
    it { should accept_nested_attributes_for(:images).allow_destroy(true) }
    it { should accept_nested_attributes_for(:time_slots) }
    it { should accept_nested_attributes_for(:emails) }
    it { should accept_nested_attributes_for(:website) }
    it { should accept_nested_attributes_for(:phone_numbers) }
  end

  # describe 'scope' do
  #   it 'has enabled status' do
  #     Category.create!(name: 'paras', image: 'sd')
  #     b = Business.create!(status: true, name: 'paras', category_id: 1)
  #     Business.enabled.should include(b)
  #   end

  #   it 'has enabled status' do
  #     Category.create!(name: 'paras', image: 'sd')
  #     b = Business.create!(status: false, name: 'paras', category_id: 1)
  #     Business.enabled.should_not include(b)
  #   end
  # end

  describe 'public instance method' do
    context 'respond to its method' do
      it { expect(Business.new).to respond_to(:keywords_sentence) }
      it { expect(Business.new).to respond_to(:fire!) }
      it { expect(Business.new).to respond_to(:setup) }
      it { expect(Business.new).to respond_to(:set_status) }
      it { expect(Business.new).to respond_to(:emails_sentence) }
      it { expect(Business.new).to respond_to(:phone_numbers_sentence) }
    end

  end

end

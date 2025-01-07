require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CreatorHelper. For example:
#
# describe CreatorHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CreatorHelper, type: :helper do
  describe '#is_creator?(email)' do
    let(:email) { 'test@example.com' }
    let(:email2) { 'test2@example.com' }
    let(:user) { User.create(email: email, password: "password", password_confirmation: "password") }
    let(:creator) { user.create_creator(first_name: 'John', last_name: 'Doe') }
    before { creator }
    context 'when email is valid' do
      it 'returns true' do
        expect(helper.is_creator?(email)).to eq true
      end
    end
    context 'when email is not valid' do
      it 'returns false' do
        expect(helper.is_creator?(email2)).to eq false
      end
    end
  end
end

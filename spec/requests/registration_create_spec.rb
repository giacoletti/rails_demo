describe 'POST /api/auth', type: :request do
  subject { response }
  let(:user) { create(:user) }
  def mock_registration_params
    {
      email: Faker::Internet.unique.email,
      password: 'my-password',
      password_confirmation: 'my-password'
    }
  end

  describe 'with valid data' do
    before do
      post '/api/auth',
           params: mock_registration_params
    end

    it 'is expected to respond with status 200' do
      expect(subject.status).to eq 200
    end

    it 'is expected to create new user' do
      expect(response_json['data']['created_at']).to be_truthy
    end
  end

  describe 'with password not matching' do
    before do
      post '/api/auth',
           params: {
             email: Faker::Internet.unique.email,
             password: 'my-password',
             password_confirmation: 'another-password'
           }
    end

    it 'is expected to respond with status 422' do
      expect(subject.status).to eq 422
    end

    it 'is expected to respond with error message' do
      expect(response_json['errors']['full_messages']).to eq ["Password confirmation doesn't match Password"]
    end
  end

  describe 'with invalid email' do
    before do
      post '/api/auth',
           params: {
             email: 'this_is_not_an_email',
             password: 'my-password',
             password_confirmation: 'my-password'
           }
    end

    it 'is expected to respond with status 422' do
      expect(subject.status).to eq 422
    end

    it 'is expected to respond with error message' do
      expect(response_json['errors']['full_messages']).to eq ["Email is not an email"]
    end
  end
end

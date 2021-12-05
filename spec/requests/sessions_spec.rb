describe 'POST /api/auth/sign_in', type: :request do
  subject { response }
  let(:user) { create(:user) }
  let(:expected_response) do
    {
      'data' => {
        'id' => user.id,
        'uid' => user.email,
        'email' => user.email,
        'provider' => 'email',
        'allow_password_change' => false
      }
    }
  end

  describe 'with valid credentials' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: user.email,
             password: user.password
           }
    end

    it 'is expected to respond with status 200' do
      expect(subject).to have_http_status 200
    end

    it 'is expected to respond with expected response' do
      expect(response_json).to eq expected_response
    end
  end

  describe 'with invalid password' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: user.email,
             password: 'wrong_password'
           }
    end

    it 'is expected to respond with status 401' do
      expect(subject).to have_http_status 401
    end

    it 'is expected to respond with error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end

  describe 'with invalid email' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: 'wrong@email.com',
             password: user.password
           }
    end

    it 'is expected to respond with status 401' do
      expect(subject.status).to eq 401
    end

    it 'is expected to respond with error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end
end

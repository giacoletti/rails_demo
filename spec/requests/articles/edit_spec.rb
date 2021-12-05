describe 'GET /api/articles/:id/edit' do
  subject { response }
  let!(:article) do
    create(:article,
           title: 'This is a wonderful news',
           content: 'My wonderful content')
  end
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }

  describe 'with valid params' do
    describe 'as an anonymous user' do
      before do
        get "/api/articles/#{article.id}/edit",
            headers: nil
      end

      it { is_expected.to have_http_status :unauthorized }

      it 'is expected to respond with an error message' do
        expect(response_json['errors']).to eq ['You need to sign in or sign up before continuing.']
      end
    end

    describe 'as an authenticated user' do
      before do
        get "/api/articles/#{article.id}/edit",
            headers: credentials
      end

      it 'is expected to respond with status 200' do
        expect(subject.status).to eq 200
      end

      it 'is expected to respond with the requested article title' do
        expect(response_json['article']['title']).to eq 'This is a wonderful news'
      end

      it 'is expected to respond with the requested article body' do
        expect(response_json['article']['content']).to eq 'My wonderful content'
      end
    end
  end

  describe 'unsuccessfully with invalid id' do
    before do
      get '/api/articles/abc/edit',
          headers: credentials
    end

    it 'is expected to respond with status 404' do
      expect(subject.status).to eq 404
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Unfortunately we cannot find the article you are looking for.'
    end
  end
end

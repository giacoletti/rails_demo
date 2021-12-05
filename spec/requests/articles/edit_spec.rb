describe 'GET /api/articles/:id/edit' do
  let!(:article) {
    create(:article,
           title: 'This is a wonderful news',
           content: 'My wonderful content')
  }
  
  subject { response }
 
  describe 'successfully' do
    before do
      get "/api/articles/#{article.id}/edit"
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

  describe 'unsuccessfully with invalid id' do
    before do
      get '/api/articles/abc/edit'
    end

    it 'is expected to respond with status 404' do
      expect(subject.status).to eq 404
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Unfortunately we cannot find the article you are looking for.'
    end
  end
end
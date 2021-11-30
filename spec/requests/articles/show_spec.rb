describe 'GET /api/articles/:id' do
  let!(:article) {
    create(:article,
           title: 'This is the latest news',
           content: 'And this is some content')
  }
  
  subject { response }
 
  describe 'successfully' do
    before do
      get "/api/articles/#{article.id}"
    end

    it 'is expected to respond with status 200' do
      expect(subject.status).to eq 200
    end

    it 'is expected to respond with the requested article title' do
      expect(response_json['title']).to eq 'This is the latest news'
    end

    it 'is expected to respond with the requested article body' do
      expect(response_json['content']).to eq 'And this is some content'
    end
  end

  describe 'unsuccessfully with invalid id' do
    before do
      get '/api/articles/abc'
    end

    it 'is expected to respond with status 404' do
      binding.pry
      expect(subject.status).to eq 404
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Unfortunately we cannot find the article you are looking for.'
    end
  end
end

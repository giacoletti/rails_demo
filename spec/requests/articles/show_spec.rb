describe 'GET /api/articles/:id' do
  describe 'successfully' do
    subject { response }

    let!(:article) {
      create(:article,
             title: 'This is the latest news',
             content: 'And this is some content')
    }

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
end

describe 'GET /api/articles' do
  describe 'successfully' do
    subject { response }
    let!(:article) { 3.times { create(:article, title: 'My Own Title') } }

    before do
      get '/api/articles'
    end

    it 'is expected to respond with status 200' do
      expect(subject.status).to eq 200
    end

    it 'is expected to return 3 articles' do
      expect(response_json.count).to eq 3
    end

    it 'is expected to respond with an article with title "My Own Title"' do
      expect(response_json.first['title']).to eq 'My Own Title'
    end
  end
end

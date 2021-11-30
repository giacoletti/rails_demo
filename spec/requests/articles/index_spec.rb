describe 'GET /api/articles' do
  
  subject { response }
  let!(:article) { create(:article, title: 'My Own Title') }

  before do
    get '/api/articles'
  end

  it 'is expected to respond with status 200' do
    expect(subject.status).to eq 200
  end

  it 'is expected to respond with an article' do
    expect(response_json.first['title']).to eq 'My Own Title'
  end
end

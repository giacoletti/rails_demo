RSpec.describe Article, type: :model do
  it { is_expected.to have_db_column :title }
  it { is_expected.to have_db_column :content }

  it 'is expected to have a valid Factory' do
    expect(create(:article)).to be_valid
  end 
end

RSpec.describe Article, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :content }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
  end

  describe 'Factory' do
    it 'is expected to have a valid Factory' do
      expect(create(:article)).to be_valid
    end 
  end
end

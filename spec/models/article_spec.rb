RSpec.describe Article, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :content }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }
  end

  describe 'Factory' do
    it 'is expected to have a valid Factory' do
      expect(create(:article)).to be_valid
    end
  end

  describe 'Image' do
    it 'is expected to be attached' do
      subject.image.attach(
        io: File.open(fixture_path + 'dummy_image.jpeg'),
        filename: 'attachment.jpeg',
        content_type: 'image/jpeg'
      )
      expect(subject.image).to be_attached
    end
  end
end

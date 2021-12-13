FactoryBot.define do
  factory :article do
    title { "Title" }
    content { "Lorem ipsum hello where there..." }
    after(:build) do |article|
      article.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_image.jpeg')),
        filename: 'dummy_image.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end

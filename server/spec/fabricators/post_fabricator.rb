require "faker"
Fabricator(:post) do
  author(fabricator: :user)
  title   { Faker::Commerce.product_name }
  content { Faker::Quotes::Shakespeare.as_you_like_it_quote }
end

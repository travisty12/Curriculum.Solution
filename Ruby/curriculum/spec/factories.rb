FactoryBot.define do
  factory(:track) do
    name {'Intro To Programming'}
  end

  factory(:lesson) do
    title {'Markdown'}
    content {'Markdown is used for lots of things! It can be useful to add documentation to your code.'}
  end
end
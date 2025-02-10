guard :rubocop, cli: [ "--format", "github", "--autocorrect" ] do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end

FROM ledermann/rails-base-builder:3.1.2-alpine AS Builder
FROM ledermann/rails-base-final:3.1.2-alpine
USER app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

FROM ledermann/rails-base-builder:3.1.2-alpine AS Builder
FROM ledermann/rails-base-final:3.1.2-alpine

# Workaround to trigger Builder's ONBUILDs to finish:
COPY --from=Builder /etc/alpine-release /tmp/dummy

USER app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

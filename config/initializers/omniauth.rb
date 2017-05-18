Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "81ob5gnooevrsd", "7WW5xoCrwZ0V7tTT"#,
  # :scope => 'r_basicprofile r_emailaddress',
  # :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]
end
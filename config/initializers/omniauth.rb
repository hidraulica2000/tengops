Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '351952801591366', '31fe7853be740590f4c45e88cdec08ce', {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access, publish_actions'}
end
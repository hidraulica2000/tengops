require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access, publish_actions, user_groups, publish_stream, user_photos'}
  provider :twitter, 'T4ySVsML1hHY7YH4fM0Q', 'fbySkbVoxLc1NN5IHyzN8qdZGX26S2Uj4wKMD7Tf8'
  provider :google_oauth2, '595769821015.apps.googleusercontent.com', 'LgHWFxdZYNf-qN19BvuXZn6Z',{
             :scope => "userinfo.email,userinfo.profile,plus.me,http://gdata.youtube.com",
             :approval_prompt => "auto"
           }
end
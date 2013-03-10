if Rails.env.production?
app_id = "371889012885215"
app_secret = "c1ef8ff9946f44c35e550540471edfac"
else
app_id = "591913890837237"
app_secret = "8d2c175cd7cf98b4c5f2fc6dc01e105c"

end
scopes = %W[
          user_about_me
          user_activities
          user_birthday
          user_education_history
          user_work_history
          user_religion_politics
          user_relationships
         ]
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, app_id, app_secret, {:scope => scopes.join(",") }
end